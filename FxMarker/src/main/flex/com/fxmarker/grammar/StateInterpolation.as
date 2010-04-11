package com.fxmarker.grammar
{
	import com.fxmarker.template.Interpolation;
	import com.fxmarker.template.TemplateElement;
	import com.fxmarker.template.TemplateFactory;
	
	[ExcludeClass]
	/**
	 * 
	 * @author User
	 * 
	 */
	internal final class StateInterpolation extends State
	{
		public function StateInterpolation(walker : StateWalker)
		{
			super(walker);
		}
		
		internal override function onStateEnter() : void{
			_element = TemplateFactory.instance.getInstance(TemplateFactory.INTERPOLATION);
		}
		
		internal override function onStateExit(containedText : String) : TemplateElement{
			element.setContent(containedText);
			return super.onStateExit(containedText);
		}
	}
}