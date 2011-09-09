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
	internal final class ExpressionSign
	{
		//Boolean
		public static const AND : String = "&&";
		public static const OR : String = "||";
		public static const NOT : String = "!";
		//Comparison
		public static const EQUALS : String = "==";
		public static const NOT_EQUALS : String = "!=";
		public static const GREATER_THAN : String = ">";
		public static const GREATER_THAN_EQUALS : String = ">=";
		public static const LESS_THAN : String = "<";
		public static const LESS_THAN_EQUALS : String = "<=";
		//Arithmetic
		public static const ADDITION : String = "+";
		public static const SUBSTRACTION : String = "-";
		public static const MULTIPLICATION : String = "*";
		public static const DIVISION : String = "/";
		public static const MODULUS : String = "%";
		public static const POWER : String = "^";
		//Assignment
		public static const ASSIGNMENT : String = "=";
		public static const ADDITION_ASSIGNMENT : String = "+=";
		public static const SUBSTRACTION_ASSIGNMENT : String = "-=";
		public static const MULTIPLICATION_ASSIGNMENT : String = "*=";
		public static const DIVISION_ASSIGNMENT : String = "/=";
		public static const MODULUS_ASSIGNMENT : String = "%=";
		//Miscelaneous
		public static const DOT : String = ".";
		public static const PARENTHESIS_OPEN : String = "(";
		public static const PARENTHESIS_CLOSE : String = ")";
		//Bitwise
		public static const BIT_AND : String = "&";
		public static const BIT_OR : String = "|";
		
		public static const FUNCTION_ARG_SEPARATOR : String = ",";
		
		public static const STRING_DELIMITER : String = "\""; 
	}
}