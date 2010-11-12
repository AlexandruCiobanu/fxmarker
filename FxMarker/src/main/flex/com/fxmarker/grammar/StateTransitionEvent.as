/**
 *   FxMarker - a template based content generator for Flex and Air applications 
 *   Copyright 2008-2010 Alex Ciobanu
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 */
package com.fxmarker.grammar
{
	import flash.events.Event;

	/**
	 * 
	 * @author Alexutz
	 * 
	 */		
	internal class StateTransitionEvent extends Event
	{
		/**
		 * 
		 */		
		public static const STATE_EXIT : String = "stateExit";
		/**
		 * 
		 */		
		public static const STATE_ENTER : String = "stateEnter";
		/**
		 * 
		 * @param state
		 * @return 
		 * 
		 */		
		public static function getStateExitEvent(exit : State, enter : State, content : String) : StateTransitionEvent{
			return new StateTransitionEvent(STATE_EXIT, exit, enter, content);
		}
		/**
		 * 
		 * @param state
		 * @return 
		 * 
		 */		
		public static function getStateEnterEvent(exit : State, enter : State) : StateTransitionEvent{
			return new StateTransitionEvent(STATE_ENTER, exit, enter);
		}
		
		private var _exitState : State;
		
		private var _enterState : State;
		
		private var _content : String;
		/**
		 * 
		 * @param type
		 * @param state
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function StateTransitionEvent(type:String, _exitState : State, _enterState : State, content : String = "")
		{
			super(type, false, false);
			this._exitState = _exitState;
			this._enterState = _enterState;
			_content = content;
		}
		/**
		 * Get the exit state of the automata 
		 * @return 
		 * 
		 */		
		public function get exitState() : State{
			return _exitState;
		}
		
		/**
		 * Get the enter state of the automata 
		 * @return 
		 * 
		 */		
		public function get enterState() : State{
			return _enterState;
		}
		
		/**
		 * Get the content text. It is only available on state exit
		 * @return 
		 * 
		 */		
		public function get content() : String{
			return _content;
		}
	}
}