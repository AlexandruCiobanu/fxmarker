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
	import com.fxmarker.util.Instanciator;
	
	import flash.utils.Dictionary;

	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public final class ExpressionFactory
	{
		private var expressionMap : Dictionary = new Dictionary();
		/**
		 * Constructor 
		 * 
		 */		
		public function ExpressionFactory(){
			//			Expression sign				           Class type			   op count  priority   left associative
			register(ExpressionSign.AND, 				 	   AndExpression, 			  	 2, 	4, 		true);
			register(ExpressionSign.OR, 				 	   OrExpression, 				 2, 	3,		true);
			register(ExpressionSign.NOT, 				 	   NotExpression, 			  	 1, 	13,		false);
			
			register(ExpressionSign.GREATER_THAN, 		 	   GreaterThanExpression, 	  	 2, 	9,		true);
			register(ExpressionSign.GREATER_THAN_EQUALS, 	   GreaterThanEqualsExpression,  2, 	9,		true);
			register(ExpressionSign.LESS_THAN, 			 	   LessThanExpression, 		  	 2, 	9,		true);
			register(ExpressionSign.LESS_THAN_EQUALS, 	 	   LessThanEqualsExpression, 	 2, 	9,		true);
			register(ExpressionSign.EQUALS, 			 	   EqualsExpression, 			 2, 	8,		true);
			register(ExpressionSign.NOT_EQUALS, 		 	   NotEqualsExpression, 		 2, 	8,		true);
			
			register(ExpressionSign.ADDITION, 			 	   AdditionExpression, 		  	 2, 	11,		true);
			register(ExpressionSign.SUBSTRACTION, 		 	   SubstractionExpression, 	  	 2, 	11,		true);
			register(ExpressionSign.MULTIPLICATION, 	 	   MultiplicationExpression, 	 2, 	12,		true);
			register(ExpressionSign.DIVISION, 			 	   DivisionExpression, 		     2, 	12,		true);
			register(ExpressionSign.POWER, 				 	   PowerExpression, 			 2, 	12,		false);
			register(ExpressionSign.MODULUS, 			 	   ModulusExpression, 		  	 2, 	12,		true);
			register(ExpressionSign.ASSIGNMENT, 		 	   AssignmentExpression, 		 2,		1,		true);
			register(ExpressionSign.ADDITION_ASSIGNMENT, 	   AdditionAssignment, 		  	 2,   	1,		true);
			register(ExpressionSign.SUBSTRACTION_ASSIGNMENT,   SubstractionAssignment,  	 2,    	1,		true);
			register(ExpressionSign.MULTIPLICATION_ASSIGNMENT, MultiplicationAssignment,	 2,    	1,		true);
			register(ExpressionSign.DIVISION_ASSIGNMENT, 	   DivisionAssignment, 		  	 2,    	1,		true);
			register(ExpressionSign.MODULUS_ASSIGNMENT,  	   ModulusAssignment,			 2,		1,		true);
			
			register(ExpressionSign.BIT_AND,  	   			   null,						 2,		13,		true);
			register(ExpressionSign.BIT_OR,  	  			   null,						 2,		13,		true);
		}
		/**
		 * 
		 * @param sign
		 * @param clasz
		 * @param parameterCount
		 * @param priority
		 * @param leftAssociative
		 * 
		 */		
		public function register(sign : String, clasz : Class, parameterCount : Number = 2, priority : int = 1, leftAssociative : Boolean = true) : void {
			expressionMap[sign] = new MapItem(clasz, parameterCount, priority, leftAssociative);
		}
		/**
		 * 
		 * @param sign
		 * @return 
		 * 
		 */		
		public function getOperator(sign : String) : Class {
			if (expressionMap[sign]) {
				return MapItem(expressionMap[sign]).type;
			}
			throw new Error("Could not find an expression for the sign " + sign);
		}
		/**
		 * 
		 * @param sign
		 * @return 
		 * 
		 */		
		public function getParameterCount(sign : String) : Number {
			if (expressionMap[sign]) {
				return MapItem(expressionMap[sign]).paramCount;
			}
			throw new Error("Could not find an expression for the sign " + sign);
		}
		/**
		 * 
		 * @param sign
		 * @return 
		 * 
		 */		
		public function isLeftAssociative(sign : String) : Boolean{
			if (expressionMap[sign]) {
				return MapItem(expressionMap[sign]).leftAssociative;
			}
			throw new Error("Could not find an expression for the sign " + sign);
		}
		/**
		 * 
		 * @param sign
		 * @return 
		 * 
		 */		
		public function getPrecedence(sign : String) : int{
			if (expressionMap[sign]) {
				return MapItem(expressionMap[sign]).priority;
			}
			throw new Error("Could not find an expression for the sign " + sign);
		}
		/**
		 * 
		 * @param sign
		 * @return 
		 * 
		 */		
		public function isOperator(sign : String) : Boolean {
			return expressionMap[sign];
		}
		/**
		 * 
		 * @param sign
		 * @param operands
		 * @return 
		 * 
		 */		
		public function getInstance(sign : String, operands : Array) : Expression{
			var paramCount : int = getParameterCount(sign);
			var length : int = operands ? operands.length: -1;
			if(length != paramCount){
				throw new Error("Wrong operator number <<" + length + ">>. Operation <<" + sign + ">> requires " + paramCount + " parameter(s)." );
			}
			return Instanciator.getInstance(getOperator(sign), operands) as Expression;
		}
	}
}
/**
 * @private 
 * @author Alexutz
 * 
 */
class MapItem{
	public var type : Class;
	
	public var paramCount : int;
	
	public var priority : int;
	
	public var leftAssociative : Boolean;
	
	public function MapItem(type : Class, paramCount : int, priority : int, leftAsscoiative : Boolean){
		this.type = type;
		this.paramCount = paramCount;
		this.priority = priority;
		this.leftAssociative = leftAsscoiative;
	}
	
}