package com.fxmarker
{
	import flexunit.framework.TestSuite;
	
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class AllTests
	{
		public static function allTests() : TestSuite{
			var test : TestSuite = new TestSuite();
			test.name= "All tests";
			test.addTest(new ContextVariableTest());
			return test;
		}
		
		public function AllTests()
		{
		}
	}
}