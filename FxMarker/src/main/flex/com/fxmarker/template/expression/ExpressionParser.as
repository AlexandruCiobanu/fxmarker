/**
 *   FxMarker - a template based content generator for Flex and Air applications 
 *   Copyright (C) 2008-2010 Alex Ciobanu
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 * 
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package com.fxmarker.template.expression
{	
	import com.fxmarker.dataModel.NullItemModel;

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
						operands.push(buildExpressionTree(tokens));
					}else{
						operands.push(getDataModel(tokens.pop()));
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