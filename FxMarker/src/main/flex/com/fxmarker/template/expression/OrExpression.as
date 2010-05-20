package com.fxmarker.template.expression 
{
	import com.fxmarker.Environment;
	/**
	 * ...
	 * @author Alexutz
	 */
	public class OrExpression extends BooleanExpression
	{
		protected var left : Expression;
		protected var right : Expression;
		
		public function OrExpression(left : Expression, right : Expression) {
			super();
			this.left = left;
			this.right = right;
		}
		
		override public function isTrue(env:Environment):Boolean {
			return left.isTrue(env) || right.isTrue(env);
		}
		
		override public function getCanonicalForm():String 
		{
			return left.getCanonicalForm() + ExpressionSign.OR + right.getCanonicalForm();;
		}
	}
}