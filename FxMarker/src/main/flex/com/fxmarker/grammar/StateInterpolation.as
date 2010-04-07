package com.fxmarker.grammar
{
	import com.fxmarker.template.Interpolation;
	import com.fxmarker.template.TemplateElement;

	internal final class StateInterpolation extends State
	{
		public function StateInterpolation(walker : StateWalker)
		{
			super(walker);
		}
		
		internal override function onStateEnter() : void{
			_element = new Interpolation();
		}
		
		internal override function onStateExit(containedText : String) : TemplateElement{
			Interpolation(element).setContent(containedText);
			return super.onStateExit(containedText);
		}
	}
}