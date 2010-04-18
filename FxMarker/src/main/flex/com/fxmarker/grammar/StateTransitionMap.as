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
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;

	[Event(name="stateExit", "com.fxmarker.grammar.StateTransitionEvent")]
	[Event(name="stateEnter", "com.fxmarker.grammar.StateTransitionEvent")]
	[ExcludeClass]
	/**
	 *  
	 * @author User
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
		 * 
		 * @param walker
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
		 * 
		 * @return 
		 * 
		 */		
		public function get currentState() : State{
			return current;
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
		
		public function evaluate(content : String) : Boolean{
			if(current == null){				
				setState(text);
			}
			var toState : State = StateTransitionElement(transitionMap[current]).evaluate(content);
			return setState(toState, StateTransitionElement(transitionMap[current]).evaluatedContent);
		}
		
		public function eof(content : String) : void{
			dispatchEvent(StateTransitionEvent.getStateExitEvent(current, content));
		}
		
		private function setState(state : State, content : String = "") : Boolean{
			if(state && current != state){
				if(current){
					dispatchEvent(StateTransitionEvent.getStateExitEvent(current, content));
				}
				current = state;
				dispatchEvent(StateTransitionEvent.getStateEnterEvent(current));
				return true;
			}
			return false;
		}		
	}
}