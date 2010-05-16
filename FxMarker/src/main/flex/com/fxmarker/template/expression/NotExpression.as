package com.fxmarker.template.expression 
{
	import com.fxmarker.Environment;
	/**
	 * ...
	 * @author Alexutz
	 */
	public class NotExpression extends BooleanExpression
	{
		private var expression : Expression;
		
		public function NotExpression() {
			super();
		}
		
		override public function isTrue(env : Environment) : Boolean {
			return !expression.isTrue(env);
		}
		
		override public function getCanonicalForm() : String {
			return "!" + expression.getCanonicalForm();;
		}
	}
}