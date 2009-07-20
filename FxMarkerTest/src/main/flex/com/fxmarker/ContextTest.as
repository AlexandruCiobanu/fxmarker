package com.fxmarker
{
	import com.fxmarker.context.Context;
	
	import flexunit.framework.TestCase;

	public class ContextTest extends TestCase
	{
		private var context : Context;
		
		public function ContextTest(methodName:String=null)
		{
			super(methodName);
			context = new Context();
		}
		
		public function testContextVariables() : void{
			context.putValue("com.aciobanu.testNumber", 7);
			var value : Object = context.getValue("com.aciobanu.testNumber");
			assertEquals("Values don't match", 7, value);
		}
		
		public function testContextVarObjectPath() : void{
			var data : Object = new Object();
			data["test"] = new Object();
			data["test"]["valoare"] = "Strike1";
			context.putValue("me.test.try", data);
			var value : Object = context.getValue("me.test.try.test.valoare");
			assertEquals("Values do not match", "Strike1", value);
		}
	}
}