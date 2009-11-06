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
	 *  Available parse messages.
	 */ 
	public class ParseMessage
	{
		private static var __initialized:Boolean = false;
		private var _toString:String = "";

		/**
		 * Nothing
		 */ 
		public static const EMPTY:ParseMessage = new ParseMessage("Empty",EnumRestrictor);
		
		/**
		 * Each time a token is read, this message is generated.
		 */ 
		public static const TOKEN_READ:ParseMessage = new ParseMessage("Token Read",EnumRestrictor); 
		
		/**
		 * When the engine is able to reduce a rule,
		 * this message is returned. The rule that was
		 * reduced is set in the GOLDParser's ReduceRule property.
		 * The tokens that are reduces and correspond to the
		 * rule's definition are stored in the Tokens() property.
		 */
		public static const REDUCTION:ParseMessage = new ParseMessage("Reduction",EnumRestrictor);

		/**
		 * The engine will return this message when the source text
		 * has been accepted as both complete and correct.
		 * In other words, the source text was successfully analyzed.
		 */
		public static const ACCEPT:ParseMessage = new ParseMessage("Accept",EnumRestrictor);
		
		/**
		 * Before any parsing can take place,
		 * a compiled Grammar Table file must be loaded.
		 */
		public static const NOT_LOADED_ERROR:ParseMessage = new ParseMessage("Not Loaded Error",EnumRestrictor);
		
		/**
		 * The tokenizer will generate this message when
		 * it is unable to recognize a series of characters
		 * as a valid token. To recover, pop the invalid
		 * token from the input queue.
		 */
		public static const LEXICAL_ERROR:ParseMessage = new ParseMessage("Lexical Error",EnumRestrictor);

		/**
		 * Often the parser will read a token that is not expected
		 * in the grammar. When this happens, the Tokens() property
		 * is filled with tokens the parsing engine expected to read.
		 * To recover, push one of the expected tokens on the input queue.
		 */
		public static const SYNTAX_ERROR:ParseMessage = new ParseMessage("Syntax Error",EnumRestrictor);

		/**
		 * The parser reached the end of the file while reading a comment.
		 * This is caused when the source text contains a "run-away"
		 * comment, or in other words, a block comment that lacks then
		 * delimeter.
		 */
		public static const COMMENT_ERROR:ParseMessage = new ParseMessage("Comment Error",EnumRestrictor);

		/**
		 * Something is wrong, very wrong.
		 */
		public static const INTERNAL_ERROR:ParseMessage = new ParseMessage("Internal Error",EnumRestrictor);

		/**
		 * A block comment is complete.
		 * When this message is returned, the content of the CurrentComment
		 * property is set to the comment text. The text includes starting and ending
		 * block comment characters. 
		 */
		public static const COMMENT_BLOCK_READ:ParseMessage = new ParseMessage("Comment Block Read",EnumRestrictor);

		/**
		 * Line comment is read.
		 * When this message is returned, the content of the CurrentComment
		 * property is set to the comment text. The text includes starting line comment characters.
		 */
		public static const COMMENT_LINE_READ:ParseMessage = new ParseMessage("Comment Line Read",EnumRestrictor);

		/**
		 * Constructor - structured to prevent external instantiation.
		 * 
		 * @param toString value returned by toString function.
		 * @param lock Private EnumRestrictor class reference used to prevent external construction.
		 */
		public function ParseMessage(toString:String,lock:Class) {
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
		public static function Parser(object:Object):ParseMessage {
			switch(Number(object)) {
				case 0:
					return ParseMessage.EMPTY;
				case 1:
					return ParseMessage.TOKEN_READ;
				case 2:
					return ParseMessage.REDUCTION;
				case 3:
					return ParseMessage.ACCEPT;
				case 4:
					return ParseMessage.NOT_LOADED_ERROR;
				case 5:
					return ParseMessage.LEXICAL_ERROR;
				case 6:
					return ParseMessage.SYNTAX_ERROR;
				case 7:
					return ParseMessage.COMMENT_ERROR;
				case 8:
					return ParseMessage.INTERNAL_ERROR;
				case 9:
					return ParseMessage.COMMENT_BLOCK_READ;
				case 10:
					return ParseMessage.COMMENT_LINE_READ;
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