/**
 *   FxMarker - a template based content generator for Flex and Air applications 
 *   Copyright (C) 2008-2010 Alex Ciobanu
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 * 
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package com.fxmarker.grammar
{
	import flash.events.Event;

	/**
	 * 
	 * @author User
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