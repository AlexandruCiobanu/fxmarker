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
package com.fxmarker.util 
{
	import mx.collections.ListCollectionView;
	/**
	 * ...
	 * @author Alexutz
	 */
	public class ListIterator implements Iterator{
		
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
			return list[index++];
		}
		
		public function get count() : int {
			return list.length;
		}		
	}
}