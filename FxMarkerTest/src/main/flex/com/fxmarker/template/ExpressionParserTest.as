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
package com.fxmarker.template
{
	import com.fxmarker.Environment;
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.template.expression.Expression;
	import com.fxmarker.template.expression.ExpressionParser;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class ExpressionParserTest
	{
		[Test]
		public function testParser() : void{
			var content : String = "2 + 3 * ( 5 - 4 ^ 2 + 1 )";
			var parser : ExpressionParser = new ExpressionParser();
			parser.whitespaceAsSeparator = true;
			var expression : Expression = parser.parse(content);
			var item : IDataItemModel = expression.getAsDataItem(new Environment(null, null, null));
			var str : String = expression.getCanonicalForm();
			assertThat(item.data, equalTo(-28));
			parser.whitespaceAsSeparator = false;
			var tokens : Array = parser.tokenize("2+3*(5-4^2+1)");
			var expression2 : Expression = parser.parse("2+3*(5-4^2+1)");
			item = expression2.getAsDataItem(new Environment(null, null, null));
			assertThat(item.data, equalTo(-28));
		}
	}
}