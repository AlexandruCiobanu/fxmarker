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