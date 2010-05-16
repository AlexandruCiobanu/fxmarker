package com.fxmarker.template.expression 
{
	import com.fxmarker.Environment;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal final class LessThanEqualsExpression extends ComparisonExpression
	{
		public function LessThanEqualsExpression() {
			super();
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + "<=" + right.getCanonicalForm();;
		}
	}
}