package com.fxmarker.grammar
{
	import com.fxmarker.template.MixedContent;
	import com.fxmarker.template.Template;
	import com.fxmarker.template.TemplateElement;
	
	import flash.utils.Dictionary;

	public final class StateWalker
	{
		internal var currentItem : TemplateElement;
		internal var itemsStack : Array = [];
		
		private var transitionMap : StateTransitionMap; 
				
		public function StateWalker(){
			transitionMap = new StateTransitionMap(this);
			transitionMap.addEventListener(StateTransitionEvent.STATE_ENTER, onStateEnter);
			transitionMap.addEventListener(StateTransitionEvent.STATE_EXIT, onStateExit);
		}
		
		public function walk(source : String) : Template{
			var template : Template = new Template();
			var buffer : String = "";
			itemsStack.push(template);
			if(source && source.length > 0){
				var index : int = 0;
				while(index < source.length){
					buffer += source.charAt(index++);
					if(transitionMap.evaluate(buffer)){
						buffer = "";
					}
				}
			}
			cleanup();
			return template;
		}
		
		internal function get parent() : Object{
			if(itemsStack && itemsStack.length > 0){
				return itemsStack[itemsStack.length - 1];
			}
			return null;
		}
		
		private function onStateEnter(event : StateTransitionEvent) : void{
			event.currentState.onStateEnter();
		}
		
		private function onStateExit(event : StateTransitionEvent) : void{
			var ref : TemplateElement = event.currentState.onStateExit(event.content);
			addToParent(ref);
			
		}
		
		private function addToParent(item : TemplateElement) : void{
			if(parent is Template){
				Template(parent).addElement(item);
			}else if(parent is MixedContent){
				MixedContent(parent).addElement(item);
			}
		}
		
		private function cleanup() : void{
			itemsStack = [];
			currentItem = null;
		}
	}
}