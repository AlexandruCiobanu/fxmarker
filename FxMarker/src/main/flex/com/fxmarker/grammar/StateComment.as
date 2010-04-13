package com.fxmarker.grammar
{
	import com.fxmarker.template.Comment;
	import com.fxmarker.template.TemplateElement;
	import com.fxmarker.template.TemplateFactory;
	
	[ExcludeClass]
	/**
	 * 
	 * @author User
	 * 
	 */	
	internal final class StateComment extends State
	{
		public function StateComment(walker : StateWalker){
			super(walker);
		}
		
		internal override function onStateEnter() : void{
			_element = TemplateFactory.instance.getInstance(TemplateFactory.COMMENT);
		}
		
		internal override function onStateExit(containedText : String) : TemplateElement{
			element.setContent(containedText);
			return super.onStateExit(containedText);
		}
	}
}