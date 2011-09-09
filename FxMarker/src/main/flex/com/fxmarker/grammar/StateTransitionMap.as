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
	import flash.events.EventDispatcher;

	[Event(name="stateExit", "com.fxmarker.grammar.StateTransitionEvent")]
	[Event(name="stateEnter", "com.fxmarker.grammar.StateTransitionEvent")]
	[ExcludeClass]
	/**
	 * State transition map used by the StateWalker state machine
	 * @author Alexutz
	 * 
	 */	
	internal final class StateTransitionMap extends EventDispatcher
	{
		private var current : State;
		
		private var transitionMap : Object;
		
		private var text : StateText;
		private var interpolation : StateInterpolation;
		private var comment : StateComment;
		private var directiveHead : StateDirectiveHead;
		private var directiveTail : StateDirectiveTail;
		private var directiveLine : StateDirectiveLine;
		
		/**
		 * Constructor
		 * @param walker reference to the State walker performing the compilation
		 * 
		 */		
		public function StateTransitionMap(walker : StateWalker){
			
			text = new StateText(walker);
			interpolation = new StateInterpolation(walker);
			comment = new StateComment(walker);
			directiveHead = new StateDirectiveHead(walker);
			directiveTail = new StateDirectiveTail(walker);
			directiveLine = new StateDirectiveLine(walker);
			
			setTransition(text, 			interpolation, 	"${"	);
			setTransition(text, 			directiveHead, 	"<#"	);
			setTransition(text, 			directiveTail, 	"</#"	);
			setTransition(interpolation, 	text, 			"}"		);
			setTransition(directiveHead, 	text, 			">"		);
			setTransition(directiveHead,	directiveLine, 	"/>"	);
			setTransition(directiveLine, 	text, 			null	);
			setTransition(directiveTail, 	text, 			">"		);
		}
		/**
		 * Get the current execution state
		 * @return State instance
		 * 
		 */		
		public function get currentState() : State{
			return current;
		}
		/**
		 * Evaluate the input in order to continue state execution
		 * @param	content string input
		 * @return flag signaling state change
		 */
		public function evaluate(content : String) : Boolean{
			if(current == null){				
				setState(text);
			}
			var toState : State = StateTransitionElement(transitionMap[current]).evaluate(content);
			return setState(toState, StateTransitionElement(transitionMap[current]).evaluatedContent);
		}
		/**
		 * Method called when the template text input ends. Needs to be called when 
		 * reaching the end of the source input in order to perform finishing checks. 
		 * @param	content string input
		 */
		public function eof(content : String) : void{
			dispatchEvent(StateTransitionEvent.getStateExitEvent(current, null, content));
		}
		
		private function setTransition(start : State, end : State, condition : Object) : void{
			if(transitionMap == null){
				transitionMap = new Object();
			}
			if(!transitionMap[start]){
				transitionMap[start] = new StateTransitionElement(start);
			}
			StateTransitionElement(transitionMap[start]).addTransition(end, condition);
		}
		
		private function setState(state : State, content : String = "") : Boolean{
			if(state && current != state){
				if (current) {
					dispatchEvent(StateTransitionEvent.getStateExitEvent(current, state, content));
				}
				var tmp : State = current;
				current = state;
				dispatchEvent(StateTransitionEvent.getStateEnterEvent(tmp, current));
				return true;
			}
			return false;
		}		
	}
}