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
 package com.fxmarker.error
{
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class ParseError extends Error
	{
		/**
		 * 
		 */		
		public static const CONTEXT_VAR_NOT_FOUND : int = 115;
		/**
		 * 
		 */		
		public static const CONTEXT_VAR_PROPERTY_NOT_DEFINED : int = 116;
		/**
		 * 
		 */		
		public static const NULL_INTERMEDIARY_PATH_ELEMENT_VALUE : int = 117;
		/**
		 * 
		 * @param variable
		 * @param templateVar
		 * @return 
		 * 
		 */		
		public static function getContextVarNotFoundError(variable : String, templateVar : String) : ParseError{
			var error : ParseError = new ParseError("", CONTEXT_VAR_NOT_FOUND);
			return error;
		}
		/**
		 * 
		 * @param varible
		 * @param property
		 * @param templateVar
		 * @return 
		 * 
		 */			
		public static function getPropertyNotDefinedError(varible : String, property : String, templateVar : String) : ParseError{
			var error : ParseError = new ParseError("", CONTEXT_VAR_PROPERTY_NOT_DEFINED);
			return error;
		}
		/**
		 * 
		 * @param varible
		 * @param property
		 * @param templateVar
		 * @return 
		 * 
		 */			
		public static function getNullPathError(varible : String, property : String, templateVar : String) : ParseError{
			var error : ParseError = new ParseError("", NULL_INTERMEDIARY_PATH_ELEMENT_VALUE);
			
			return error;
		}
		
		private var _contextVar : String;
		
		private var _property : String;
		/**
		 * 
		 * @param message
		 * @param id
		 * 
		 */		
		public function ParseError(message:String="", id:int=0)
		{
			//TODO: implement function
			super(message, id);
		}
	}
}