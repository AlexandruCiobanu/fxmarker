package com.fxmarker.template.expression 
{
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class PowerExpression extends ArithmeticExpression
	{
		
		public function PowerExpression(left : Expression, right : Expression) {
			super(left, right);
			operation = ExpressionSign.POWER;
		}
		
		override protected function compute(a : Number, b : Number) : Number {
			return Math.pow(a, b);
		}		
	}
}