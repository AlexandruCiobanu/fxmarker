package com.fxmarker.grammar
{
	import com.fxmarker.template.TemplateElement;
	import com.fxmarker.template.TemplateFactory;
	
	import mx.messaging.management.Attribute;
	
	[ExcludeClass]
	/**
	 * 
	 * @author User
	 * 
	 */
	internal final class StateDirectiveTail extends State
	{
		public function StateDirectiveTail(walker : StateWalker)
		{
			super(walker);
		}
		
		internal override function onStateEnter() : void{
			//do nothing
		}
		
		internal override function onStateExit(containedText : String) : TemplateElement{
			var directiveName : String = TemplateFactory.instance.getName(peekItemsStack());
			if(containedText != directiveName){
				throw new Error("Wrong end tag for directive " + directiveName + ". End tag " + containedText + " does not match expected content.");
			}
			_element = walker.itemsStack.pop();
			
			return super.onStateExit(containedText);
		}
		
		private function peekItemsStack() : TemplateElement{
			return walker.itemsStack[walker.itemsStack.length - 1] as TemplateElement;
		}
	}
}