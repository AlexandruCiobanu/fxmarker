package com.fxmarker.template.expression 
{
	/**
	 * ...
	 * @author Alexutz
	 */
	public class ParentheticalExpression extends Expression
	{
		private var nestedExpression : Expression;
		
		public function ParentheticalExpression() {
			super();
		}
		
		override public function getCanonicalForm() : String {
			return "(" + nestedExpression.getCanonicalForm() + ")";
		}
	}
}