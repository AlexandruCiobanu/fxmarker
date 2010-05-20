package com.fxmarker.template.expression 
{
	/**
	 * ...
	 * @author Alexutz
	 */
	public class ModulusExpression extends ArithmeticExpression
	{
		
		public function ModulusExpression(left : Expression, right : Expression) {
			super(left, right);
			operation = ExpressionSign.MODULUS;
		}
		
		override protected function compute(a : Number, b : Number) : Number {
			return a % b;
		}		
	}
}