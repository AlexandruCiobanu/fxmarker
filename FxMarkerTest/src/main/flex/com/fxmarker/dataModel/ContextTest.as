/**
 *   FxMarker - a template based content generator for Flex and Air applications 
 *   Copyright 2008-2010 Alex Ciobanu
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 */
 package com.fxmarker.dataModel
{
	import flexunit.framework.Assert;

	public class ContextTest
	{
		private var context : DataModel;
		
		public function ContextTest(){
			context = new DataModel();
		}
		
		[Test]
		public function testContextVariables() : void{
			context.putValue("com.aciobanu.testNumber", 7);
			var value : Object = context.getValue("com.aciobanu.testNumber");
			Assert.assertEquals("Values don't match", 7, value.data);
		}
		
		[Test]
		public function testContextVarObjectPath() : void{
			/*var data : Object = new Object();
			data["test"] = new Object();
			data["test"]["valoare"] = "Strike1";
			context.putValue("me.test.try", data);
			var value : Object = context.getValue("me.test.try.test.valoare");
			Assert.assertEquals("Values do not match", "Strike1", value.data);
		*/}
	}
}