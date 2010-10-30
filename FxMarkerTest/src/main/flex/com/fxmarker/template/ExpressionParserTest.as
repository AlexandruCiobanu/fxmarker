package com.fxmarker.template
{
	import com.fxmarker.template.expression.Expression;
	import com.fxmarker.template.expression.ExpressionParser;

	public class ExpressionParserTest
	{
		[Test]
		public function testParser() : void{
			var content : String = "2 + 3 * (5 - 4^2)";
			var parser : ExpressionParser = new ExpressionParser();
			var expression : Expression = parser.parse(content);
			
		}
	}
}