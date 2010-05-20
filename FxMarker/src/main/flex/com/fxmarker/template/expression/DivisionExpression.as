package com.fxmarker.template.expression 
{
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class DivisionExpression extends ArithmeticExpression
	{
		
		public function DivisionExpression(left : Expression, right : Expression) {
			super(left, right);
			operation = ExpressionSign.DIVISION;
		}
		
		override protected function compute(a : Number, b : Number) : Number {
			return a / b;
		}		
	}
}