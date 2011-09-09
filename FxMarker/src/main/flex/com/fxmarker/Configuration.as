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
	import mx.formatters.DateFormatter;
	import mx.formatters.NumberFormatter;
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class Configuration
	{
		/**
		 * 
		 */		
		public var whiteSpaceAsSeparator : Boolean = false;
		/**
		 * 
		 */		
		fxm_internal var dateFormatter : DateFormatter;
		/**
		 * 
		 */		
		fxm_internal var numberFormatter : NumberFormatter;
		
		/**
		 * 
		 * 
		 */		
		public function Configuration(){ }
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set dateFormat(value : String) : void{
			getDateFormatter().formatString = value;
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set decimalSeparatorFrom(value:String):void{
			getNumberFormatter().decimalSeparatorFrom = value;
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set decimalSeparatorTo(value:String):void{
			getNumberFormatter().decimalSeparatorTo = value;
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set precision(value:Object):void{
			getNumberFormatter().precision = value;
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set rounding(value:String):void{
			getNumberFormatter().rounding = value;
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set thousandsSeparatorFrom(value:String):void{
			getNumberFormatter().thousandsSeparatorFrom = value;
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set thousandsSeparatorTo(value:String):void{
			getNumberFormatter().thousandsSeparatorTo = value;
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set useNegativeSign(value : Boolean) : void{
			getNumberFormatter().useNegativeSign = value;
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set useThousandsSeparator(value : Boolean) : void{
			getNumberFormatter().useThousandsSeparator = value;
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		private function getDateFormatter() : DateFormatter{
			if(!fxm_internal::dateFormatter){
				fxm_internal::dateFormatter = new DateFormatter();
			}
			return fxm_internal::dateFormatter;
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		private function getNumberFormatter() : NumberFormatter{
			if(!fxm_internal::numberFormatter){
				fxm_internal::numberFormatter = new NumberFormatter();
			}
			return fxm_internal::numberFormatter;
		}
	}
}