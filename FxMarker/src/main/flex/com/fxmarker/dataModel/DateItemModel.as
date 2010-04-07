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
				if(config.fxm_internal::dateFormatter){
					return config.fxm_internal::dateFormatter.format(date);
				}
				return date.toString();
			}
			return "";
		}
		
	}
}