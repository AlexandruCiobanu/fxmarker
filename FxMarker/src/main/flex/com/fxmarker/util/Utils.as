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
	import mx.utils.StringUtil;
	/**
	 * 
	 * @author aCiobanu
	 * 
	 */	
	public class Utils
	{
		/**
		 * 
		 * @param string
		 * @return 
		 * 
		 */		
		public static function isEmpty(string : String) : Boolean{
			return string == null || StringUtil.trim(string) == ""; 
		}
		
		public static function endsWith(string : String, s : String) : Boolean{
			return string != null && s != null && s == string.substring(string.length - s.length);
		}
		
		public function Utils()
		{
			throw new Error("Do not instanciate Utils class.");
		}
	}
}