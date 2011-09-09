/**
 *   FxMarker - a template based content generator for Flex and Air applications 
 *   Copyright 2008-2010 Alex Ciobanu
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 */
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
		public var whitespaceAsSeparator : Boolean = false;
		
		private var factory : ExpressionFactory;
		
		private var currentExpression : String;
		/**
		 * 
		 */
		public function ExpressionParser() {
			factory = new ExpressionFactory();
		}
		/**
		 * 
		 * @param content
		 * @param configuration
		 * @return 
		 * 
		 */			
		public function parse(content : String) : Expression{
			if(!content){
				return null;
			}
						
			currentExpression = content;
			//step 1: extract the tokens from the expression string
			var tokens : Array = tokenize(content);
			//step 2: process the tokens, creating a list in Reverse Polish Notation 
			var RPN : Array = parseShuntingYard(tokens);
			//step 3 : Create the expression objects
			var expression : Expression = buildExpressionTree(RPN);
			currentExpression = null;
			return expression;
		}
		
		private function isParenthesisOpen(sign : String ) : Boolean {
			return sign == ExpressionSign.PARENTHESIS_OPEN;
		}
		
		private function isParenthesisClosed(sign : String ) : Boolean {
			return sign == ExpressionSign.PARENTHESIS_CLOSE;
		}
		
		public function tokenize(content : String) : Array{
			var tokens : Array;
			if(whitespaceAsSeparator){
				tokens = content.split(" ");
			}else{
				tokens = [];
				var position : int = 0;
				var char : String = "";
				var buffer : String = "";
				while(position < content.length){
					char = content.charAt(position++);
					if(factory.isOperator(char)){
						tokens.push(buffer);
						buffer = "";
						if(position < content.length){
							char += content.charAt(position);
							if(!factory.isOperator(char)){
								tokens.push(char.charAt(0));
								continue;
							}
							position++;
						}
						tokens.push(char);
					}else if(isParenthesisClosed(char) || isParenthesisOpen(char)){
						if(buffer){
							tokens.push(buffer);
							buffer = "";
						}
						tokens.push(char);
					}else{
						buffer += char;
					}
				}				
			}
			if(buffer){
				tokens.push(buffer);
				buffer = "";
			}
			return tokens;
		}
		
		private function parseShuntingYard(tokens : Array) : Array {
			var index : int = 0;
			var token : String;
			var outputQueue : Array = [];
			var operatorStack : Array = [];
			while(index < tokens.length){
				token = tokens[index++];
				if (factory.isOperator(token)) {
					while(shouldPopOperators(token, operatorStack)){
						outputQueue.push(operatorStack.pop());
					}
					operatorStack.push(token);
					continue;
				}
				if(isParenthesisOpen(token)){
					operatorStack.push(token);
					continue;
				}
				if(isParenthesisClosed(token)){
					while(!isParenthesisOpen(operatorStack[operatorStack.length-1])){
						outputQueue.push(operatorStack.pop());
					}
					if(operatorStack.length == 0){
						throw new Error("Mismatched parenthesis found in the expression " + currentExpression + " at token " + token);
					}
					//pop the opened parenthesis
					operatorStack.pop();					
					continue;
				}
				if(token.charAt(0) == ExpressionSign.STRING_DELIMITER){
					while(token.charAt(token.length - 1) != ExpressionSign.STRING_DELIMITER && index < tokens.length){
						token += " " + tokens[index++];
					}
					if(token.charAt(token.length - 1) != ExpressionSign.STRING_DELIMITER){
						throw new Error("Ending quotes not found in the expression" + currentExpression + " at token " + token);
					}
				}
				outputQueue.push(token);
			}
			while(operatorStack.length > 0){
				token = operatorStack[operatorStack.length - 1];
				if(isParenthesisClosed(token) || isParenthesisOpen(token)){
					throw new Error("Mismatched parenthesis found in the expression " + currentExpression);
				}
				operatorStack.pop();
				outputQueue.push(token);
			}
			return outputQueue;
		}
		
		private function shouldPopOperators(op1 : String, opStack : Array) : Boolean{
			if(opStack.length > 0){
				var op2 : String = opStack[opStack.length - 1];
				return factory.isOperator(op2) && (
						( factory.isLeftAssociative(op1) && factory.getPrecedence(op1) <= factory.getPrecedence(op2)) ||
						(!factory.isLeftAssociative(op1) && factory.getPrecedence(op1) <  factory.getPrecedence(op2)));
			}
			return false;
		}
		
		private function buildExpressionTree(tokens : Array) : Expression{
			var token : String;
			var operator : Expression;			
			var operands : Array = [];
			token = tokens.pop();
			if(factory.isOperator(token)){
				var paramCount : int = factory.getParameterCount(token);
				var operand : String;
				for(var index : int = 0; index < paramCount; index++){
					operand = tokens[tokens.length - 1];
					if(factory.isOperator(operand)){
						operands.unshift(buildExpressionTree(tokens));
					}else{
						operands.unshift(getDataModel(tokens.pop()));
					}
				}
				operator = factory.getInstance(token, operands);
			}else{
				operator = getDataModel(token);
			}
			return operator;
		}
		
		private function getDataModel(operand : String) : Expression{
			if(operand == null){
				return new StringConstant(null);
			}
			//operand = StringUtil.trim(operand);
			//check for string constants
			if(operand.indexOf(ExpressionSign.STRING_DELIMITER) == 0){
				return new StringConstant(operand.substring(1, operand.length - 1));			
			}
			//check for numbers
			var firstChar : int = operand.charCodeAt(0);
			if(firstChar > 47 && firstChar < 58 ){
				return new NumberConstant(parseInt(operand));
			}
			//check for identifiers
			var tokens : Array = operand.split(".");
			var expression : Expression = new Identifier(tokens[0] as String);
			for (var i : int = 1; i < tokens.length; i++) {
				expression = new Dot(expression, tokens[i] as String);
			}
			return expression;
		}
	}
}