package com.fxmarker.grammar
{
	import com.fxmarker.template.Template;
	
	import flash.utils.Dictionary;

	internal final class StateWalker
	{
		private var buffer : String;
		
		private var transitionMap : StateTransitionMap; 
				
		public function StateWalker(){
			transitionMap = new StateTransitionMap();
		}
		
		public function walk(source : String) : Template{
			var template : Template = new Template();
			var currentState : State;
			return template;
		}
	}
}