package com.fxmarker.grammar
{
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
    
	[ExcludeClass]
	/**
	 *  
	 * @author User
	 * 
	 */	
	internal final class StateTransitionMap
	{
		private var current : State;
		
		private var transitionMap : Dictionary;
		/**
		 * 
		 * @param walker
		 * 
		 */		
		public function StateTransitionMap(walker : StateWalker){
			
			var text : StateText = new StateText(walker);
			var interpolation : StateInterpolation = new StateInterpolation(walker);
			var comment : StateComment = new StateComment(walker);
			var directiveHead : StateDirectiveHead = new StateDirectiveHead(walker);
			var directiveTail : StateDirectiveTail = new StateDirectiveTail(walker);
			var directiveLine : StateDirectiveLine = new StateDirectiveLine(walker);
			
			setTransition(text, 			interpolation, 	"${"	);
			setTransition(text, 			directiveHead, 	"<#"	);
			setTransition(text, 			directiveTail, 	"</#"	);
			setTransition(interpolation, 	text, 			"}"		);
			setTransition(directiveHead, 	text, 			">"		);
			setTransition(directiveHead,	directiveLine, 	"/>"	);
			setTransition(directiveLine, 	text, 			null	);
			setTransition(directiveTail, 	text, 			">"		);
			
			current = text;
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
				transitionMap = new Dictionary();
			}
			if(!transitionMap[start]){
				transitionMap[start] = new StateTransitionElement(start);
			}
			StateTransitionElement(transitionMap[start]).addTransition(end, condition);
		}
		
		public function evaluate(content : String) : Boolean{
			var toState : State = StateTransitionElement(transitionMap[current]).evaluate(content);
			
			if(toState == current){
				return false;
			}
			
			current = toState;
			return true;
		}
		
		
	}
}