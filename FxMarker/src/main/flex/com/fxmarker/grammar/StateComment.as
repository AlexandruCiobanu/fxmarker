package com.fxmarker.grammar
{
	import com.fxmarker.template.Comment;
	import com.fxmarker.template.TemplateElement;

	internal final class StateComment extends State
	{
		public function StateComment(walker : StateWalker){
			super(walker);
		}
		
		internal override function onStateEnter() : void{
			_element = new Comment();
		}
		
		internal override function onStateExit(containedText : String) : TemplateElement{
			Comment(element).setContent(containedText);
			return super.onStateExit(containedText);
		}
	}
}