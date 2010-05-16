package com.fxmarker.template.expression 
{
	import com.fxmarker.Environment;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class GreaterThanExpression extends ComparisonExpression
	{		
		public function GreaterThanExpression() {
			super();			
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + ">" + right.getCanonicalForm();
		}		
	}
}