package com.fxmarker
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