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
package com.fxmarker.template 
{
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author ...
	 */
	public class TemplateInlineElement extends TemplateElement
	{
		private var _ownerTemplateElementTypes : Array;
		
		public function TemplateInlineElement()
		{
			super();			
		}
		
		protected function setOwnerTemplateElementType(type : Class) : void {
			if(type){
				if (!_ownerTemplateElementTypes) {
					_ownerTemplateElementTypes = [];
				}
				_ownerTemplateElementTypes.push(getQualifiedClassName(type));
			}
		}
		
		override internal function set parent(value : TemplateElement) : void {
			if (value && _ownerTemplateElementTypes) {
				var parentType : String = getQualifiedClassName(value);
				var isValid : Boolean;
				for each(var type : String in _ownerTemplateElementTypes) {
					if (type == parentType) {
						isValid = true;
						break;
					}
				}
				if (isValid) {
					super.parent = value;
					return;
				}
			}
			
			throw new Error("Illegal use of directive. Wrong parent");
		}
	}
}