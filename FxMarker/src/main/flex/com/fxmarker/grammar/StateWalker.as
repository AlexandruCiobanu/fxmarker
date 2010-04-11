package com.fxmarker.grammar
{
	import com.fxmarker.template.Template;
	import com.fxmarker.template.TemplateElement;
	
	import flash.utils.Dictionary;

	internal final class StateWalker
	{
		internal var currentItem : TemplateElement;
		internal var itemsStack : Array = [];
		internal var parent : Object;
		
		private var transitionMap : StateTransitionMap; 
				
		public function StateWalker(){
			transitionMap = new StateTransitionMap(this);
		}
		
		public function walk(source : String) : Template{
			var template : Template = new Template();
			var buffer : String = "";
			parent = template;
			itemsStack.push(parent);
			if(source && source.length > 0){
				var index : int = 0;
				while(index < source.length){
					buffer += source.charAt(index);
					if(transitionMap.evaluate(buffer)){
						
					}
				}
			}
			cleanup();
			return template;
		}
		
		
		private function cleanup() : void{
			parent = null;
			itemsStack = [];
			currentItem = null;
		}
	}
}