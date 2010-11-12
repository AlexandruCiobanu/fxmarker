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