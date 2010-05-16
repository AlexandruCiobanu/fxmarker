package com.fxmarker.template.expression 
{
	/**
	 * ...
	 * @author Alexutz
	 */
	internal final class NotEqualsExpression extends EqualsExpression
	{
		public function NotEqualsExpression() {
			super();
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + "!=" + right.getCanonicalForm();;
		}
	}
}