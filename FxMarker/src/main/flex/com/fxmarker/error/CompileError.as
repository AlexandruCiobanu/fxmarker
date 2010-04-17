package com.fxmarker.error
{
	import com.fxmarker.template.TemplateElement;

	public final class CompileError extends Error
	{
		public function CompileError(element : TemplateElement, message:*="", id:*=0){
			super(message, id);
		}
	}
}