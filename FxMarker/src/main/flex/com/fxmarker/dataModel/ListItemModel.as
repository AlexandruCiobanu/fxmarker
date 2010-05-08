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
	import com.fxmarker.util.Iterator;
	import com.fxmarker.util.ListIterator;
	import mx.collections.ListCollectionView;
	/**
	 * ...
	 * @author Alexutz
	 */
	public class ListItemModel implements IDataItemModel
	{
		private var list : Object;
		
		public function ListItemModel() {
			
		}
		
		/* INTERFACE com.fxmarker.dataModel.IDataItemModel */
		
		public function get data():* {
			return list;
		}
		
		public function set data(value:*):void{
			if (!list || list is Array || list is ListCollectionView) {
				list = value;
			}else {
				throw new Error("Not a list!");
			}
		}
		
		public function getAsString(config:Configuration) : String {
			if (list) {
				return list.toString();
			}
			return "";
		}	
		
		public function getIterator() : Iterator {
			return new ListIterator(list);
		}
	}
}