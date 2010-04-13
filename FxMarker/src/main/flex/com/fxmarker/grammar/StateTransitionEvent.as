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
		public static function getStateExitEvent(state : State, content : String) : StateTransitionEvent{
			return new StateTransitionEvent(STATE_EXIT, state, content);
		}
		/**
		 * 
		 * @param state
		 * @return 
		 * 
		 */		
		public static function getStateEnterEvent(state : State) : StateTransitionEvent{
			return new StateTransitionEvent(STATE_ENTER, state);
		}
		
		private var _currentState : State;
		
		private var _content : String;
		/**
		 * 
		 * @param type
		 * @param state
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function StateTransitionEvent(type:String, state : State, content : String = "")
		{
			super(type, false, false);
			_currentState = state;
			_content = content;
		}
		/**
		 * Get the current state the automata is in 
		 * @return 
		 * 
		 */		
		public function get currentState() : State{
			return _currentState;
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