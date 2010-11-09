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
		
		public static const FUNCTION_ARG_SEPARATOR : String = ",";
		
		public static const STRING_DELIMITER : String = "\""; 
	}
}