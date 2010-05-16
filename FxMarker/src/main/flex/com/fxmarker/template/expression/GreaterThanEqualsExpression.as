package com.fxmarker.template.expression 
{
	import com.fxmarker.Environment;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class GreaterThanEqualsExpression extends ComparisonExpression
	{
		public function GreaterThanEqualsExpression() {
			super();
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + ">=" + right.getCanonicalForm();;
		}		
	}
}