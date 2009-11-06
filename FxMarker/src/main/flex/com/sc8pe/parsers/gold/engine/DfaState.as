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
	
	/**
	 * State in the Deterministic Finite Automata
	 * which is used by the tokenizer.
	 */
	public class DfaState
	{
		private var _index:int;
		internal var _acceptSymbol:Symbol;
		internal var _transitionVector:ObjectMap;

		/**
		 * Creates a new instance of the <code>DfaState</code> class.
		 * 
		 * @param index				Index in the DFA state table.
		 * @param acceptSymbol		Symbol to accept.
		 * @param transitionVector	The transition vector.
		 */
		public function DfaState(index:int, acceptSymbol:Symbol, transitionVector:ObjectMap) {
			_index = index;
			_acceptSymbol = acceptSymbol;
			_transitionVector = transitionVector;
		}

		/**
		 * Gets index of the state in DFA state table.
		 */
		public function get Index():int {
			return _index;
		}
		
		/**
		 * Gets the symbol which can be accepted in this DFA state.
		 */
		 public function get AcceptSymbol():Symbol {
		 	return _acceptSymbol;
		 }

	}
}