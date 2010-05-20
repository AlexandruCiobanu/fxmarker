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
		fxm_internal var dateFormatter : DateFormatter;
		/**
		 * 
		 */		
		fxm_internal var numberFormatter : NumberFormatter;
		
		private var numberFormat : NumberFormatter;
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