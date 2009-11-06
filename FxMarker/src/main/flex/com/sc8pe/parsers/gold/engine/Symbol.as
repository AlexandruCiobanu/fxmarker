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
	import com.sc8pe.parsers.gold.engine.SymbolType;
	
	/**
	 * Represents a terminal or noterminal symbol used by the
	 * Deterministic Finite Automata (DFA) and LR Parser.
	 * 
	 * Symbols can be either terminals (which represent a class of
	 * tokens - such as identifiers) or nonterminals (which represent
	 * the rules and structures of the grammer).  Terminal symbols
	 * fall into several categories for use by the GOLD Parser Engine
	 * which are enumerated in the <code>SymbolType</code> enumeration.
	 * 
	 */ 
	public class Symbol
	{
		internal var _index:int;
		private var _name:String;
		internal var _symbolType:SymbolType;
		private var _text:String;
		
		private static const quotedChars:String = "|-+*?()[]{}<>!";
		
		/**
		 * Creates a new instance of the <code>Symbol</code> class.
		 * 
		 * @param index Symbol index in the symbol table.
		 * @param name Name of the symbol.
		 * @param symbolType Type of the symbol.
		 */
		public function Symbol(index:int, name:String, symbolType:SymbolType) {
			_index = index;
			_name = name;
			_symbolType = symbolType;
		}
				
		/**
		 * Returns the index of the symbol in the GOLD Parser object's symbol table.
		 */ 
		public function get Index():int {
			return _index;
		}

		/**
		 * Returns the name of the symbol.
		 */ 
		public function get Name():String {
			return _name;
		}
		
		/**
		 * Returns an enumerated data type that denotes
		 * the class of symbols that the object belongs to.
		 */
		public function get symbolType():SymbolType {
			return _symbolType;
		}

		/**
		 * Returns the text representation of the symbol.
		 * In the case of nonterminals, the name is delimited by angle brackets,
		 * special terminals are delimited by parenthesis
		 * and terminals are delimited by single quotes
		 * (if special characters are present).
		 * 
		 * @returns String representation of symbol.
		 */
		public function toString():String {
			if (_text == null) {
				switch (_symbolType) {
					case SymbolType.NON_TERMINAL:
						_text = '<' + _name + '>';
						break;
					case SymbolType.TERMINAL:
						_text = FormatTerminalSymbol(_name);
						break;
					default:
						_text = '(' + _name + ')';
						break;
				}	
			}
			return _text;
		}
		
		/*
		 * Format the terminal symbol.
		 */
		private static function FormatTerminalSymbol(source:String):String {
			var result:String = "";
			for (var i:int = 0; i < source.length; i++) {
				var ch:String = source.charAt(i);
				if (ch == "'") {
					result += "''";
				}
				else if (IsQuotedChar(ch) || (ch == "\"")) {
					result += "'" + ch + "'";
				}
				else {
					result += ch;
				}
			}
			return result;
		}
		
		/*
		 * Check to see if character is a special "quoted" character.
		 */
		private static function IsQuotedChar(value:String):Boolean {
			return (quotedChars.indexOf(value) >=0);
		}		
		
	}
}