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