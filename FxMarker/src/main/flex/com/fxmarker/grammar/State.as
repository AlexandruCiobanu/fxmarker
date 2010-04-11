package com.fxmarker.grammar
{
	import com.fxmarker.template.TemplateElement;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[ExcludeClass]
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	internal class State
	{
		protected var _element : TemplateElement;
		
		protected var walker : StateWalker;
		
		public function State(walker : StateWalker){
			this.walker = walker;
		}
		
		public function get element() : TemplateElement{
			return _element;
		}
		
		internal function onStateEnter() : void{
			
		}
		
		internal function onStateExit(containedText : String) : TemplateElement{
			//perform item cleanup
			var item : TemplateElement = element;
			_element = null;
			return item;
		}
	}
}