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
	/**
	 *  Type of symbol.
	 */ 
	public class SymbolType
	{
		private static var __initialized:Boolean = false;
		private var _toString:String = "";

		/**
		 * Normal nonterminal.
		 */ 
		public static const NON_TERMINAL:SymbolType = new SymbolType("NonTerminal",EnumRestrictor);
		
		/**
		 * Normal terminal.
		 */ 
		public static const TERMINAL:SymbolType = new SymbolType("Terminal",EnumRestrictor); 
		
		/**
		 * The Whitespace symbol is a special terminal that is
		 * automatically ignored by the parsing engine.
		 * Any text accepted as whitespace is considered to be
		 * inconsequential and "meaningless".
		 */
		public static const WHITESPACE:SymbolType = new SymbolType("Whitespace",EnumRestrictor);

		/**
		 * The End symbol is generated when the tokenizer
		 * reaches the end of the source text.
		 */
		public static const END:SymbolType = new SymbolType("End",EnumRestrictor);
		
		/**
		 * This type of symbol designates the start of a block quote.
		 */
		public static const COMMENT_START:SymbolType = new SymbolType("CommentStart",EnumRestrictor);
		
		/**
		 * This type of symbol designates the end of a block quote.
		 */
		public static const COMMENT_END:SymbolType = new SymbolType("CommentEnd",EnumRestrictor);

		/**
		 * When the engine reads a token that is recognized as a line
		 * comment, the remaining characters on the line are automatically
		 * ignored by the parser.
		 */
		public static const COMMENT_LINE:SymbolType = new SymbolType("CommentLine",EnumRestrictor);

		/**
		 * The Error symbol is a general-purpose means of representing characters
		 * that were not recognized by the tokenizer. In other words, when the tokenizer
		 * reads a series of characters that is not accepted by the DFA engine, a token
		 * of this type is created.
		 */
		public static const ERROR:SymbolType = new SymbolType("Error",EnumRestrictor);

		/**
		 * Constructor - structured to prevent external instantiation.
		 * 
		 * @param toString value returned by toString function.
		 * @param lock Private EnumRestrictor class reference used to prevent external construction.
		 */
		public function SymbolType(toString:String,lock:Class) {
			checkLock(lock);
			_toString = toString;
		}
		
		/**
		 * Conversion to access specific value of the enum.
		 */
		public function toString():String {
			return _toString;
		}
		
		/**
		 * Parse a passed object, and return the associated enumeration if possible.
		 * 
		 * @object The object to parse.
		 */  
		public static function Parse(object:Object):SymbolType {
			switch (Number(object)) {
				case 0:
					return SymbolType.NON_TERMINAL;
				case 1:
					return SymbolType.TERMINAL;
				case 2:
					return SymbolType.WHITESPACE;
				case 3:
					return SymbolType.END;
				case 4:
					return SymbolType.COMMENT_START;
				case 5:
					return SymbolType.COMMENT_END;
				case 6:
					return SymbolType.COMMENT_LINE;
				case 7:
					return SymbolType.ERROR;
				default:
					return null;
			}
			return null;
		}

		/**
		 * Check to allow creation of instances of public static const, but 
		 * throws runtime exception if the constructor is called externally 
		 * via "new".
		 * 
		 * @param lock Class reference that must be an EnumRestrictor class reference
		 *             which is available only internal to this class.
		 */
		private function checkLock(lock:Class):void {
			if (__initialized && !(lock is EnumRestrictor)) {
				throw new Error('This enumerated class cannot be constructed');
			}			
		}

		/**
		 *  Static code block magic, this code is initialized AFTER all public static const 
		 *  are initialized. This is a trick to support private constructors.
		 */		
		{
			__initialized = true;
		}
		
	}
}

/**
 * This is a "private" class which is not accessible anywhere outside
 * of this file.  This ensures that outsiders will not be able to
 * run the constructor because the lock needs to be this class type.
 */
class EnumRestrictor {
}