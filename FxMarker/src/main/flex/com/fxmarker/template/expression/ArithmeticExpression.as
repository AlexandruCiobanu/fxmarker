package com.fxmarker.template.expression 
{
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class ArithmeticExpression extends Expression
	{
		protected var left : Expression;		
		protected var right : Expression;
		protected var operation : String;
		
		public function ArithmeticExpression() {
			super();
		}	
		
		override public final function isTrue(env : Environment) : Boolean {
			return new Error("Not Applicable");
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + operation + right.getCanonicalForm();;
		}
	}
}