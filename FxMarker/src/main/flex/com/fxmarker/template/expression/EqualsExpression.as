package com.fxmarker.template.expression 
{
	import com.fxmarker.Environment;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class EqualsExpression extends ComparisonExpression
	{
		public function EqualsExpression() {
			super();
		}
		
		override public function isTrue(env : Environment) : Boolean {
			return left.isTrue(env) == right.isTrue(env);
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + "==" + right.getCanonicalForm();
		}
	}
}