/**
 *   FxMarker - a template based content generator for Flex and Air applications 
 *   Copyright (C) 2008-2009 Alex Ciobanu
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 * 
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
 package com.fxmarker
{
	import com.fxmarker.dataModel.DataModel;
	
	import flexunit.framework.TestCase;

	public class ContextTest extends TestCase
	{
		private var context : DataModel;
		
		public function ContextTest(methodName:String=null)
		{
			super(methodName);
			context = new DataModel();
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