package com.fxmarker
{
	import flexunit.framework.TestCase;

	public class ContextVariableTest extends TestCase
	{
		public function ContextVariableTest(methodName:String=null)
		{
			super(methodName);
		}
		
		public function simpleVariableTest() : void{
			var template : String="This is a ${simpleVarTest}";
			FxMarker.instance.parse(template);
		}
		
		public function variablePathTest() : void{
			
		}		
	}
}