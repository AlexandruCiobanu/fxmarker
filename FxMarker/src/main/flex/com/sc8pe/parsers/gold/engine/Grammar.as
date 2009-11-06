/**
* Gold Parser engine.
* See more details on http://www.devincook.com/goldparser/
* 
* Original code is written in VB by Devin Cook (GOLDParser@DevinCook.com)
*
* This translation is done by Reggie Wilbanks (GOLDParser@sc8pe.com) 
* 
* The translation is based on the other engine translations:
* C# engine by Vladimir Morozov (vmoroz@hotmail.com)
* Delphi engine by Alexandre Rai (riccio@gmx.at)
* C# engine by Marcus Klimstra (klimstra@home.nl)
*/
package com.sc8pe.parsers.gold.engine
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

		
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	[Event(name="complete", type="flash.events.Event")]
	   	
	/**
	 * Contains grammar tables required for parsing.
	 */ 
	public class Grammar extends EventDispatcher
	{
		/**
		* Identifies Gold parser grammar file.
		*/
		public static const FileHeader:String = "GOLD Parser Tables/v1.0";
		 
		// Grammar header information
		public var Parameters:Dictionary;

		// Tables read from the persisted grammar (file or xml)
		private  var m_symbolTable:Dictionary;		// Symbol table
		private  var m_charSetTable:Dictionary;		// Charset table
		internal var m_ruleTable:Dictionary;		// Rule table
		internal var m_dfaStateTable:Dictionary;	// DFA state table
		internal var m_lrStateTable:Dictionary;			// LR state table

		// Initial states
		internal var m_dfaInitialStateIndex:int;	// DFA initial state index
		internal var m_dfaInitialState:DfaState;	// DFA initial state 
		internal var m_lrInitialState:int;			// LR initial state

		// Internal state of grammar parser
		private var m_entryCount:int;				// Number of entries left

		internal var m_errorSymbol:Symbol;
		internal var m_endSymbol:Symbol;		

		/**
		 * Creates a new instance of <code>Grammar</code> class
		 * 
		 * @param GrammarData This object may be a url reference, or 
		 * actual xml in the "GOLD Parser Tables/v1.0" xml format, of the grammar to be loaded.
		 */
		public function Grammar(GrammarData:Object = null) {
			
			// Initialize the dictionaries
			Parameters = new Dictionary();
			m_symbolTable = new Dictionary();
			m_ruleTable = new Dictionary();
			m_charSetTable = new Dictionary();
			m_dfaStateTable = new Dictionary();
			m_lrStateTable = new Dictionary();
			
			// It's actually an xml object, so just process it
			if (GrammarData is XML) {
				loadFromXMLObject(GrammarData as XML);
			}
			else if (GrammarData is String) {
				// Check to see if it's a string of xml
				var xml:XML = getXMLObject(GrammarData as String);
				if (xml == null) { // It's not a valid string of xml, so it might be a url
					loadURL(GrammarData as String);
				}
				else { // The string was valid xml, so an xml object was returned
					loadFromXMLObject(xml);
				}
			}
			//TODO: Another else if case to handle local file system files (for AIR and Flash 10) 
		}

		/**
		 * Loads the grammar tables from a string of XML.
		 * 
		 * @param xml The string of XML to load the grammar tables from.
		 */
		public function loadFromXMLString(xmlString:String):Boolean {
			return loadFromXMLObject(getXMLObject(xmlString));
		}
				 
		/**
		 * Loads the grammar tables from an XML object.
		 *
		 * @param xml The XML object to load the grammar tables from. 
		 */
		public function loadFromXMLObject(xml:XML):Boolean {
			try {
				var loopIndex:int; // One variable to rule them all...
				
				// Read Header
				for each(var parameter:XML in xml.Parameters.Parameter) {
					Parameters[parameter.attribute("Name").toString()] = parameter.attribute("Value").toString();
				}
				
				// Read Symbols
				trace("----- SYMBOLS -----");
				var symbolTableSize:int = Number(xml.SymbolTable.attribute("Count").toString());
				for each(var symbol:XML in xml.SymbolTable.Symbol) {
					var newSymbolType:SymbolType = SymbolType.Parse(symbol.attribute("Kind").toString());
					var newSymbol:Symbol = new Symbol(Number(symbol.attribute("Index").toString()),symbol.attribute("Name").toString(),newSymbolType);
					switch (newSymbolType) {
						case SymbolType.END:
							m_endSymbol = newSymbol;
							break;
						case SymbolType.ERROR:
							m_errorSymbol = newSymbol;
							break;
					}
					m_symbolTable[newSymbol.Index] = newSymbol;
	//				trace(newSymbol.Index.toString() + ": " + m_symbolTable[newSymbol.Index].toString());
				}
				
				
				// Read Rules
				trace("----- RULES -----");
				for each(var rule:XML in xml.RuleTable.Rule) {
					var ruleSymbols:Array = new Array();
					for each (var ruleSymbol:XML in rule.RuleSymbol) {
						ruleSymbols.push(m_symbolTable[Number(ruleSymbol.attribute("SymbolIndex").toString())]);
					}
					var newRule:Rule = new Rule(Number(rule.attribute("Index").toString()),m_symbolTable[Number(rule.attribute("NonTerminalIndex").toString())],ruleSymbols);
					m_ruleTable[newRule.Index] = newRule;
	//				trace(newRule.Index.toString() + ": " + m_ruleTable[newRule.Index].toString());
				}
	
				// Read Char Sets
				trace("----- CHAR SETS -----");
				for each(var charSet:XML in xml.CharSetTable.CharSet) {
					var charSetString:String = "";
					for each (var char:XML in charSet.Char) {
						charSetString += String.fromCharCode(char.attribute("UnicodeIndex").toString());
					}
					m_charSetTable[charSet.attribute("Index").toString()] = charSetString;
	//				trace(charSet.attribute("Index").toString() + ": " + m_charSetTable[charSet.attribute("Index").toString()]);
				}
	
				// Read DFA State Table
				trace("----- DFA States -----");
				m_dfaInitialStateIndex = Number(xml.DFATable.attribute("InitialState").toString());
				for each(var dfaState:XML in xml.DFATable.DFAState) {
					var edges:Array = new Array();
					for each (var dfaEdge:XML in dfaState.DFAEdge) {
						edges.push({CharSetIndex: Number(dfaEdge.attribute("CharSetIndex").toString()), TargetIndex: Number(dfaEdge.attribute("Target").toString())});
					}
					var transitionVector:ObjectMap = CreateDfaTransitionVector(edges);
					var newDfaState:DfaState = new DfaState(dfaState.attribute("Index").toString(),m_symbolTable[Number(dfaState.attribute("AcceptSymbol").toString())],transitionVector);
					m_dfaStateTable[newDfaState.Index] = newDfaState;
				}
				m_dfaInitialState = m_dfaStateTable[m_dfaInitialStateIndex];
				// Optimize DFA Transition Vectors
				for each(var state:DfaState in m_dfaStateTable) {
					var transitions:ObjectMap = state._transitionVector;
					for (loopIndex = transitions.Count; --loopIndex >=0;) {
						var key:int = transitions.GetKey(loopIndex);
						var transition:Object = transitions.getItemAt(key);
						if (transition != null) {
							var transitionIndex:int = Number(transition);
							if (transitionIndex >= 0) {
								transitions.setItemAt(key, m_dfaStateTable[transitionIndex]);
							}
							else {
								transitions.setItemAt(key,null);
							}
						}
					}
					transitions.ReadOnly = true;
				}
	
				trace("----- LALR States -----");
				m_lrInitialState = Number(xml.LALRTable.attribute("InitialState").toString());
				for each(var lalrState:XML in xml.LALRTable.LALRState) {
					var stateActions:Array = new Array();
					var stateActionLength:int = 0;
					for each (var stateAction:XML in lalrState.LALRAction) {
						var newStateAction:LRStateAction = new LRStateAction(stateActionLength,
																			m_symbolTable[Number(stateAction.attribute("SymbolIndex").toString())],
																			LRAction.Parser(stateAction.attribute("Action").toString()),
																			Number(stateAction.attribute("Value").toString()));
						stateActionLength++;
						stateActions.push(newStateAction);
					}		
					// Create transition vector
					var lrTransitionVector:Array = new Array(symbolTableSize);
					for(loopIndex = 0; loopIndex != lrTransitionVector.length; loopIndex++) {
						lrTransitionVector[loopIndex] = null;
					}
					for(loopIndex = 0; loopIndex != stateActionLength; loopIndex++) {
						lrTransitionVector[stateActions[loopIndex].symbol.Index] = stateActions[loopIndex];
					}
					var newLRState:LRState = new LRState(Number(lalrState.attribute("Index").toString()),stateActions,lrTransitionVector);
					m_lrStateTable[newLRState.Index] = newLRState;
				}
			}
			catch (e:Error) {
				dispatchEvent(FaultEvent.createEvent(new Fault(e.errorID.toString(),e.message)));
				return false;
			}
			dispatchEvent(new Event("complete"));
			return true;
		}
		
	
		/**
		 * Gets the start symbol for the grammar.
		 */
		public function get StartSymbol():Symbol {
			return m_symbolTable[Parameters["Start Symbol"]];
		}
		
		/**
		 * Get the value indicating if the grammar is case sensitive.
		 */
		public function get CaseSensitive():Boolean {
			return Boolean(Parameters["Case Sensitive"]);
		}
		
		/**
		 * Gets the initial DFA state.
		 */
		public function get DfaInitialState():DfaState {
			return m_dfaInitialState;
		}
		
		/**
		 * Gets the initial LR state.
		 */
		public function get InitialLRState():LRState {
			return m_lrStateTable[m_lrInitialState];
		}
		
		/**
		 * Gets a special symbol to designate last token in the input stream.
		 */
		public function get EndSymbol():Symbol {
			return m_endSymbol;
		}
		
		// Private functions //
		
		/*
		* Returns an XML object from the data string, if possible.
		*/
		private function getXMLObject(data:String):XML {
			var xml:XML;
			
			try {
				xml = new XML(data);
			}
			catch(e:Error) {
				return null;
			}
			
			if (xml.nodeKind() != "element") {
				return null;
			}
			return xml;
		}
		
		/*
		* Load the URL.
		*/
		private function loadURL(url:String):void {
			var service:HTTPService = new HTTPService();
			service.url = url;
			service.resultFormat = HTTPService.RESULT_FORMAT_E4X;
			service.addEventListener(ResultEvent.RESULT,resultHandler);
			service.addEventListener(FaultEvent.FAULT,faultHandler);
			service.send();
		}
		
		/*
		* Handles the result of the URL load.
		*/
		private function resultHandler(event:ResultEvent):void {
			if (event.result is String) {
				loadFromXMLString(event.result as String);
			}
			else if (event.result is XML) {
				loadFromXMLObject(event.result as XML);
			}
		}
		
		/*
		* Handles the fault condition.
		*/
		private function faultHandler(event:FaultEvent):void {
			dispatchEvent(event.clone());
		}
				
		/*
		* Creates a DFA trasition vector from edges
		*/
		private function CreateDfaTransitionVector(edges:Array):ObjectMap {			
			var transitionVector:ObjectMap = new ObjectMap();
			for (var loopIndex:int = edges.length; --loopIndex >= 0;) {
				var charSet:String = m_charSetTable[edges[loopIndex].CharSetIndex];
				for (var j:int = 0; j < charSet.length; j++) {
					transitionVector.setItemAt(charSet.charCodeAt(j),edges[loopIndex].TargetIndex);
				}
			}
			return transitionVector;
		}		
	}
}