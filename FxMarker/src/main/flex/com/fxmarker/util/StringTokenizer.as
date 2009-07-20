package com.fxmarker.util
{
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class StringTokenizer
	{
		private var tokens : Array;
		
		private var currentToken : int = -1;
		/**
		 * 
		 * 
		 */		
		public function StringTokenizer(delimiter : String = null, value : String = null){
			tokenize(value, delimiter); 
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function hasMoreTokens() : Boolean{
			return tokens && currentToken < tokens.length - 1;
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function getToken() : String{
			if(currentToken >= tokens.length - 1){
				throw new Error("");
			}
			currentToken++;
			var token : String = tokens[currentToken] as String;
			return token;
		}
		/**
		 * 
		 * @param value
		 * @param delimiter
		 * 
		 */		
		public function tokenize(value : String, delimiter : String) : void{
			if(value == null || delimiter == null){
				return;
			}
			tokens = value.split(delimiter);
			currentToken = -1;
		}
	}
}