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
	import com.sc8pe.parsers.gold.engine.LRAction;
	
	/**
	 *  Action in an LR State.
	 */ 
	public class LRStateAction
	{
		private var _index:int;
		private var _symbol:Symbol;
		private var _action:LRAction;
		private var _value:int;
		
		/**
		 * Creates a new instance of the <code>LRStateAction</code> class.
		 * 
		 * @param index Index of the LR state action.
		 * @param symbol Symbol associated with the action.
		 * @param action Action type.
		 * @param value Action value.
		 */
		public function LRStateAction(index:int, symbol:Symbol, action:LRAction, value:int) {
			_index = index;
			_symbol = symbol
			_action = action;
			_value = value;
		}
		
		/**
		 * Gets the index of the LR state action.
		 */
		public function get Index():int {
			return _index;
		}
		
		/**
		 * Gets the symbol associated with the LR state action.
		 */ 
		public function get symbol():Symbol {
			return _symbol;
		}
		
		/**
		 * Get the action value.
		 */
		public function get Action():LRAction {
			return _action;
		}

		/**
		 * Returns LR state action by its index.
		 * 
		 * @param index LR state action index.
		 * 
		 * @returns LR state action for the given index.
		 */
		public function get Value():int {
			return _value;
		}
				
	}
}