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
	/**
	 * ...
	 * @author Alexutz
	 */
	public class BooleanItemModel extends DataItemModel
	{
		public static const TRUE : BooleanItemModel = new BooleanItemModel(true);
		public static const FALSE : BooleanItemModel = new BooleanItemModel(false);
		
		private static var initialized : Boolean = false;
		
		{
			initialized = true;
		}
		
		public function BooleanItemModel(data : Boolean) {
			super(null);
			if (initialized) {
				throw new Error("Use TRUE/FALSE accessors");
			}
			super.data = data;
		}	
		
		override public final function set data(value:*):void {}
	}
}