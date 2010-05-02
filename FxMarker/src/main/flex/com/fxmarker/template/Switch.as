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
	import com.fxmarker.Environment;
	internal final class Switch extends TemplateElement
	{
		private var testExpression : String;
		
		public function Switch(){
			super();
		}
		
		override public function setContent(content : String):void {
			testExpression = content;
		}		
		
		override public function addElement(element : TemplateElement) : void {
			if (!_nestedElements) {
				_nestedElements = [];
			}
			if (element is CaseBlock) {
				_nestedElements.push(element);
			}else if(_nestedElements.length > 0){
				CaseBlock(_nestedElements[_nestedElements.length - 1]).addElement(element);
			}
		}
		
		override public function accept(env : Environment) : void {
			super.accept(env);
			try {
				
			}catch (error : BreakError) {
				//do nothing
			}
		}
	}
}