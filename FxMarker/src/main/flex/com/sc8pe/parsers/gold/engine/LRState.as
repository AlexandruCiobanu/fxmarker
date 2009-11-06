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
	import com.sc8pe.parsers.gold.engine.LRStateAction;
	
	/**
	 *  State of LR parser.
	 */ 
	public class LRState
	{
		private var _index:int;
		private var _actions:Array;
		internal var _transitionVector:Array;
		
		/**
		 * Creates a new instance of the <code>LRState</code> class.
		 * 
		 * @param index Index of the LR state in the LR state table.
		 * @param actions List of all available LR actions in this state.
		 * @param transitionVector Transition vector which has symbol index as an index.
		 */
		public function LRState(index:int, actions:Array, transitionVector:Array) {
			_index = index;
			_actions = actions;
			_transitionVector = transitionVector;
		}
		
		/**
		 * Gets the index of the LR state in LR state table.
		 */
		public function get Index():int {
			return _index;
		}
		
		/**
		 * Gets the state action count.
		 */ 
		public function get ActionCount():int {
			return _actions.length;
		}
		
		/**
		 * Returns LR state action by its index.
		 * 
		 * @param index LR state action index.
		 * 
		 * @returns LR state action for the given index.
		 */
		public function GetAction(index:int):LRStateAction {
			return _actions[index];
		}
		
		/**
		 * Returns LR state action by symbol index.
		 * 
		 * @param symbolIndex Symbol index to search for.
		 * 
		 * @returns LR state action for the given symbol index.
		 */
		public function GetActionBySymbolIndex(symbolIndex:int):LRStateAction {
			return _transitionVector[symbolIndex];
		}
		
	}
}