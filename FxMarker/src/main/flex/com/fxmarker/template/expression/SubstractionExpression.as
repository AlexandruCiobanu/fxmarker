package com.fxmarker.template.expression 
{
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class SubstractionExpression extends ArithmeticExpression
	{
		
		public function SubstractionExpression(left : Expression, right : Expression) {
			super(left, right);
			operation = ExpressionSign.SUBSTRACTION;
		}	
		
		override protected function compute(a:Number, b:Number):Number 
		{
			return a - b;
		}
	}
}