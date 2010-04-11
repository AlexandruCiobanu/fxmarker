package com.fxmarker.grammar
{
	import com.fxmarker.template.TemplateElement;
	import com.fxmarker.template.TemplateFactory;
	
	[ExcludeClass]
	/**
	 * 
	 * @author User
	 * 
	 */	
	internal final class StateDirectiveHead extends State
	{
		public function StateDirectiveHead(walker : StateWalker)
		{
			super(walker);
		}
		
		internal override function onStateEnter() : void{
			//do nothing here
		}
		
		internal override function onStateExit(containedText : String) : TemplateElement{
			var index : int = containedText.indexOf(" ");
			var elementName : String = containedText.substring(0, index); 
			var content : String = containedText.substring(index);	
			
			_element = TemplateFactory.instance.getInstance(elementName);
			_element.setContent(content);
			walker.itemsStack.push(_element);
			
			
			return super.onStateExit(containedText);
		}
	}
}