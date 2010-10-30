package com.fxmarker.template.expression 
{
	import com.fxmarker.Environment;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class AndExpression extends OrExpression
	{		
		public function AndExpression(left : Expression, right : Expression) {
			super(left, right);
		}
		
		override public function isTrue(env : Environment) : Boolean {
			return left.isTrue(env) && right.isTrue(env);
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + "&&" + right.getCanonicalForm();;
		}		
	}
}