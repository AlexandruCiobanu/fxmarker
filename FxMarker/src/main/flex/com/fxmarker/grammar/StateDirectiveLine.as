package com.fxmarker.grammar
{
	import com.fxmarker.template.TemplateElement;
	
	[ExcludeClass]
	/**
	 * 
	 * @author User
	 * 
	 */
	internal final class StateDirectiveLine extends State
	{
		public function StateDirectiveLine(walker:StateWalker)
		{
			super(walker);
		}
		
		internal override function onStateEnter() : void{
			//do nothing here
		}
		
		internal override function onStateExit(containedText : String) : TemplateElement{
			walker.itemsStack.pop();
			return super.onStateExit(containedText);
		}
	}
}