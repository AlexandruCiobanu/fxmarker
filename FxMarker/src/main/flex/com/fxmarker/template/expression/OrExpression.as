package com.fxmarker.template.expression 
{
	import com.fxmarker.Environment;
	/**
	 * ...
	 * @author Alexutz
	 */
	public class OrExpression extends BooleanExpression
	{
		protected var left : Expression;
		protected var right : Expression;
		
		public function OrExpression() {
			super();			
		}
		
		override public function isTrue(env:Environment):Boolean {
			return left.isTrue(env) || right.isTrue(env);
		}
		
		override public function getCanonicalForm():String 
		{
			return left.getCanonicalForm() + "||" + right.getCanonicalForm();;
		}
	}
}