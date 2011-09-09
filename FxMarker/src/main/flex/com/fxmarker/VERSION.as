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
 package com.fxmarker
{
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public final class VERSION
	{
		/**
		 * 
		 * @return 
		 * 
		 */		
		public static function get Version() : String{
			return "1.0 beta";
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public static function get Name() : String{
			return "FxMarker";
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public static function get Link() : String{
			return "http://code.google.com/p/fxmarker";
		}
		/**
		 * 
		 * 
		 */		
		public function VERSION()
		{
			throw new Error("Do not instanciate this class");
		}

	}
}