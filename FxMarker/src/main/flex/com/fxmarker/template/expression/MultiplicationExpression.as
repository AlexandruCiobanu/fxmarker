package com.fxmarker.template.expression 
{
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class MultiplicationExpression extends ArithmeticExpression
	{
		
		public function MultiplicationExpression(left : Expression, right : Expression) {
			super(left, right);
			operation = ExpressionSign.MULTIPLICATION;
		}
		
		override protected function compute(a : Number, b : Number) : Number {
			return a * b;
		}		
	}
}