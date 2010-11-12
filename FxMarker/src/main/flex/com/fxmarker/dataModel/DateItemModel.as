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
 package com.fxmarker.dataModel
{
	import com.fxmarker.Configuration;
	import com.fxmarker.fxm_internal;
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class DateItemModel implements IDataItemModel
	{
		private var date : Date;
		
		public function DateItemModel(data : Date){
			this.data = data;
		}

		public function get data():*
		{
			return date;
		}
		
		public function set data(value:*):void
		{
			date = value;
		}
		
		public function getAsString(config:Configuration):String
		{
			if(date){
				if(config && config.fxm_internal::dateFormatter){
					return config.fxm_internal::dateFormatter.format(date);
				}
				return date.toString();
			}
			return "";
		}
		
	}
}