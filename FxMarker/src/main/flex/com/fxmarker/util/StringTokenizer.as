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
 package com.fxmarker.util
{
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class StringTokenizer implements Iterator
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
		public function hasNext() : Boolean{
			return tokens && currentToken < tokens.length - 1;
		}
		
		public function get count() : int{
			return tokens ? tokens.length : 0;
		} 
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function next() : *{
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