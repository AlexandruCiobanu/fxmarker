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
	import com.fxmarker.dataModel.ObjectWrapper;
	
	import mx.collections.ListCollectionView;

	/**
	 * ...
	 * @author Alexutz
	 */
	public class ListIterator implements Iterator{
		private static var wrapper : ObjectWrapper = new ObjectWrapper();
		
		private var list : Object;
		private var index : int = 0;
		
		public function ListIterator(list : Object) {
			if(!list || list is Array || list is ListCollectionView){
				this.list = list;
			}else {
				throw new Error("Not a list!");
			}
		}
		
		/* INTERFACE com.fxmarker.util.IIterator */
		
		public function hasNext() : Boolean {
			return list && index < list.length;
		}
		
		public function next() : * {
			return wrapper.wrap(list[index++]);
		}
		
		public function get count() : int {
			return list.length;
		}		
	}
}