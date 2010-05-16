package com.fxmarker.template.expression 
{
	import com.fxmarker.Environment;
	/**
	 * ...
	 * @author Alexutz
	 */
	public class LessThanExpression extends ComparisonExpression
	{
		public function LessThanExpression() {
			super();			
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + "<" + right.getCanonicalForm();;
		}		
	}
}