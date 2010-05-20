package com.fxmarker.template.expression 
{
	/**
	 * ...
	 * @author Alexutz
	 */
	internal final class AdditionExpression extends ArithmeticExpression
	{
		
		public function AdditionExpression(left : Expression, right : Expression) {
			super(left, right);
			operation = ExpressionSign.ADDITION;
		}
		
		override protected function compute(a : Number, b : Number) : Number {
			return a + b;
		}		
	}
}