package com.fxmarker.grammar
{
	import com.fxmarker.template.TemplateElement;
	import com.fxmarker.template.TextBlock;

	internal final class StateText extends State
	{
		public function StateText(walker : StateWalker)
		{
			super(walker);
		}
		
		internal override function onStateEnter() : void{
			_element = new TextBlock();
		}
		
		internal override function onStateExit(containedText : String) : TemplateElement{
			TextBlock(_element).setContent(containedText);
			return super.onStateExit(containedText);
		}
	}
}