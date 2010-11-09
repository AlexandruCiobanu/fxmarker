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
package com.fxmarker.template.expression
{
	import com.fxmarker.Environment;
	import com.fxmarker.dataModel.HashItemModel;
	import com.fxmarker.dataModel.IDataItemModel;

	/**
	 * ...
	 * @author Alexutz
	 */
	internal class Dot extends Expression
	{
		private var target : Expression;
		
		private var key : String;
		
		public function Dot(target : Expression, key : String) {
			super();			
			this.target = target;
			this.key = key;
		}
		
		override public function getAsDataItem(env : Environment) : IDataItemModel {
			var left : IDataItemModel = target.getAsDataItem(env);
			if (left && left is HashItemModel) {
				left = HashItemModel(left).getValue(key);
				return left;
			}
			return null;
		}
		
		override public function getCanonicalForm() : String {
			return target.getCanonicalForm() + "." + key;
		}
	}
}