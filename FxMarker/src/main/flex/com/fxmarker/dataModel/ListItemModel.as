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
		
		public function ListItemModel(value : *) {
			data = value;
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