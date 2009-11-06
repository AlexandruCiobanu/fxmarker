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
	 *  LR parser action type.
	 */ 
	public class LRAction
	{
		private static var __initialized:Boolean = false;
		private var _toString:String = "";

		/**
		 * No action. Not used.
		 */ 
		public static const NONE:LRAction = new LRAction("None",EnumRestrictor);
		
		/**
		 * Shift a symbol and go to a state.
		 */ 
		public static const SHIFT:LRAction = new LRAction("Shift",EnumRestrictor); 
		
		/**
		 * Reduce by a specified rule.
		 */
		public static const REDUCE:LRAction = new LRAction("Reduce",EnumRestrictor);

		/**
		 * Go to a state on reduction.
		 */
		public static const GOTO:LRAction = new LRAction("Goto",EnumRestrictor);
		
		/**
		 * Input successfully parsed.
		 */
		public static const ACCEPT:LRAction = new LRAction("Accept",EnumRestrictor);
		
		/**
		 * Error.
		 */
		public static const ERROR:LRAction = new LRAction("Error",EnumRestrictor);

		/**
		 * Constructor - structured to prevent external instantiation.
		 * 
		 * @param toString value returned by toString function. 
		 * @param lock Private EnumRestrictor class reference used to prevent external construction.
		 */
		public function LRAction(toString:String,lock:Class) {
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
		public static function Parser(object:Object):LRAction {
			switch(Number(object)) {
				case 0:
					return LRAction.NONE;
				case 1:
					return LRAction.SHIFT;
				case 2:
					return LRAction.REDUCE;
				case 3:
					return LRAction.GOTO;
				case 4:
					return LRAction.ACCEPT;
				case 5:
					return LRAction.ERROR;
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