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
			assertThat(item.data, equalTo(-4));
			parser.whitespaceAsSeparator = false;
			var tokens : Array = parser.tokenize("2+3*(5-4^2+1)");
			var expression2 : Expression = parser.parse("2+3*(5-4^2+1)");
			item = expression2.getAsDataItem(new Environment(null, null, null));
			assertThat(item.data, equalTo(-4));
		}
	}
}