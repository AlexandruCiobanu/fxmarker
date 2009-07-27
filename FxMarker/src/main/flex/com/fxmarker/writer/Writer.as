/**
 *   FxMarker - a template based content generator for Flex and Air applications 
 *   Copyright (C) 2008-2009 Alex Ciobanu
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
 package com.fxmarker.writer
{
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class Writer
	{
		private var buffer : String;
		/**
		 * 
		 * 
		 */		
		public function Writer(){
			buffer = "";
		}
		/**
		 * 
		 * @param data
		 * @param length
		 * 
		 */		
		public final function write(data : String, length : Number = NaN) : void{
			if(data){
				var dataToWrite : String;
				if(isNaN(length) || length < 0 || length >= data.length){
					dataToWrite = data;
				}else{
					dataToWrite = data.substring(0, length);
				}
				doWrite(dataToWrite);
			}
		}
		/**
		 * 
		 * @return 
		 * 
		 */				
		public function get writtenData() : String{
			return new String(buffer);
		}	
		/**
		 * 
		 * @param data
		 * 
		 */		
		protected function doWrite(data : String) : void{ 
			buffer += data;
		}	
	}
}