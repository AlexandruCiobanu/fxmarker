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
	import com.sc8pe.parsers.gold.engine.Symbol;
	import com.sc8pe.parsers.gold.engine.SymbolType;
	
	/**
	 * Rules are the logical structures of the grammar.
	 *
	 * Rules consist of a head containing a nonterminal
	 * followed by a series of both nonterminals and terminals. 
	 */ 
	public class Rule
	{
		private var _index:int;
		internal var _nonTerminal:Symbol;
		internal var _symbols:Array;
		internal var _containsOneNonTerminal:Boolean;
				
		/**
		 * Creates a new instance of the <code>Rule</code> class.
		 * 
		 * @param index Index of the rule in the grammar rule table.
		 * @param nonTerminal Nonterminal of the rule.
		 * @param symbols Terminal and nonterminal symbols of the rule.
		 */
		public function Rule(index:int, nonTerminal:Symbol, symbols:Array) {
			_index = index;
			_nonTerminal = nonTerminal;
			_symbols = symbols;
			_containsOneNonTerminal = (symbols.length == 1) && (symbols[0].symbolType == SymbolType.NON_TERMINAL);
		}
				
		/**
		 * Gets the index of the rule in the rule table.
		 */ 
		public function get Index():int {
			return _index;
		}

		/**
		 * Gets the head symbol of the rule.
		 */ 
		public function get NonTerminal():Symbol {
			return _nonTerminal;
		}

		/**
		 * Gets the name of the rule.
		 */ 
		public function get Name():String {
			return "<" + _nonTerminal.Name + ">";
		}
		
		/**
		 * Gets the number of symbols.
		 */ 
		public function get Count():int {
			return _symbols.length;
		}
		
		/**
		 * Returns the symbol by its index.
		 */ 
		public function getItemAt(index:int):Symbol {
			return _symbols[index];
		}
	
		/**
		 * Gets true if the rule contains exactly on symbol.
		 * Used by the parser object to TrimReductions.
		 */ 
		public function get ContainsOneNonTerminal():Boolean {
			return _containsOneNonTerminal;
		}
		
		/**
		 * Gets the rule definition.
		 */ 
		public function get Definition():String {
			var result:String = "";
			for (var i:int = 0; i < _symbols.length; i++) {
				result += _symbols[i].toString();
				if (i < _symbols.length - 1) {
					result += " ";
				}	
			}
			return result;
		}

		/**
		 * Returns the Backus-Noir representation of the rule.
		 */ 
		public function toString():String {
			return Name + " ::= " + Definition;
		}

	}
}