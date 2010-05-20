package com.fxmarker.template.expression 
{
	/**
	 * ...
	 * @author Alexutz
	 */
	public class ParentheticalExpression extends Expression
	{
		private var nestedExpression : Expression;
		
		public function ParentheticalExpression(nestedExpression : Expression) {
			super();
			this.nestedExpression = nestedExpression;
		}
		
		override public function getCanonicalForm() : String {
			return "(" + nestedExpression.getCanonicalForm() + ")";
		}
	}
}