package com.fxmarker.grammar
{
	import com.fxmarker.template.TemplateElement;
	import com.fxmarker.template.TemplateFactory;
	import com.fxmarker.template.TextBlock;
	
	[ExcludeClass]
	/**
	 * 
	 * @author User
	 * 
	 */
	internal final class StateText extends State
	{
		public function StateText(walker : StateWalker)
		{
			super(walker);
		}
		
		internal override function onStateEnter() : void{
			_element = TemplateFactory.instance.getInstance(TemplateFactory.TEXT);
		}
		
		internal override function onStateExit(containedText : String) : TemplateElement{
			if(containedText){
				_element.setContent(containedText);
			}else{
				_element = null;
			}
			return super.onStateExit(containedText);
		}
	}
}