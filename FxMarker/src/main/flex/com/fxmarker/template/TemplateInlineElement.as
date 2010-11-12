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