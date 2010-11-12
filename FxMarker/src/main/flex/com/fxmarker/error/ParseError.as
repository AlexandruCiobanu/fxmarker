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
		public function ParseError(message:String="", id:int=0){
			super(message, id);
		}
	}
}