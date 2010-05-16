package com.fxmarker.template.expression
{
	/**
	 * ...
	 * @author Alexutz
	 */
	public final class ExpressionParser{
		
		private static var _instance : ExpressionParser;
		/**
		 * 
		 * @return 
		 */
		public static function get instance() : ExpressionParser {
			if (!_instance) {
				_instance = new ExpressionParser();
			}
			return _instance;
		}
		/**
		 * 
		 */
		public function ExpressionParser() {
			
		}	
		/**
		 * 
		 * @param	content
		 * @return
		 */
		public function parse(content : String) : Expression {
			//TODO: Need a suitable expression parsing algorithm
			//For now we only support dotted identifier chains
			var tokens : Array = content.split(".");
			var expression : Expression = new Identifier(tokens[0] as String);
			for (var i : int = 1; i < tokens.length - 1; i++) {
				expression = new Dot(expression, tokens[i] as String);
			}
			return expression;
		}
	}
}