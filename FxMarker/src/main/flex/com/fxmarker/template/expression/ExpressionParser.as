package com.fxmarker.template.expression
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Alexutz
	 */
	public final class ExpressionParser{
		
		private static var _instance : ExpressionParser;
		
		private var expressionMap : Dictionary = new Dictionary();
		
		private var position : Number;
		
		private var expressionString : String;
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
			register(ExpressionSign.AND, AndExpression, 2);
			register(ExpressionSign.OR, OrExpression, 2);
			register(ExpressionSign.NOT, NotExpression, 1);
			register(ExpressionSign.GREATER_THAN, GreaterThanExpression, 2);
			register(ExpressionSign.GREATER_THAN_EQUALS, GreaterThanEqualsExpression, 2);
			register(ExpressionSign.LESS_THAN, LessThanExpression, 2);
			register(ExpressionSign.LESS_THAN_EQUALS, LessThanEqualsExpression, 2);
			register(ExpressionSign.EQUALS, EqualsExpression, 2);
			register(ExpressionSign.NOT_EQUALS, NotEqualsExpression, 2);
			register(ExpressionSign.ADDITION, AdditionExpression, 2);
			register(ExpressionSign.SUBSTRACTION, SubstractionExpression, 2);
			register(ExpressionSign.MULTIPLICATION, MultiplicationExpression, 2);
			register(ExpressionSign.DIVISION, DivisionExpression, 2);
			register(ExpressionSign.POWER, PowerExpression, 2);
			register(ExpressionSign.MODULUS, ModulusExpression, 2);
		}
		
		private function register(sign : String, clasz : Class, parameterCount : Number = 0) : void {
			expressionMap[sign] = { type : clasz, paramCount: parameterCount };
		}
		
		private function getOperator(sign : String) : Class {
			if (expressionMap[sign]) {
				return expressionMap[sign].type as Class;
			}
			throw new Error("Could not find an expression for the sign " + sign);
		}
		
		private function getParameterCount(sign : String) : Number {
			if (expressionMap[sign]) {
				return expressionMap[sign].paramCount as Number;
			}
			throw new Error("Could not find an expression for the sign " + sign);
		}
		
		private function isOperator(sign : String) : Boolean {
			return expressionMap[sign];
		}
		
		private function isParenthesisOpen(sign : String ) : Boolean {
			return sign == ExpressionSign.PARENTHESIS_OPEN;
		}
		
		private function isParenthesisClosed(sign : String ) : Boolean {
			return sign == ExpressionSign.PARENTHESIS_CLOSE;
		}
		
		/**
		 * 
		 * @param	content
		 * @return
		 */
		public function parse(content : String) : Expression {
			position = 0;
			expressionString = content;
			var operatorStack : Array = [];
			var operandStack : Array = [];
			var char : String = "";
			try{
				while (position < expressionString.length) {
					char += expressionString.charAt(position++)
					if (isOperator(char)) {
						operatorStack.push(getOperator(char));
						char = "";
					}else if (isParenthesisOpen(char)) {
						operatorStack.push(ParentheticalExpression);
						char = "";
					}else if (isParenthesisClosed(char)) {
						char = "";
					}else {
						
					}
				}
			}finally {
				position = 0;
				expressionString = null;
			}
			
			
			/*var tokens : Array = content.split(".");
			var expression : Expression = new Identifier(tokens[0] as String);
			for (var i : int = 1; i < tokens.length - 1; i++) {
				expression = new Dot(expression, tokens[i] as String);
			}
			return expression;*/
			return null;
		}
	}
}