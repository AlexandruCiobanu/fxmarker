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
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class MixedContent extends TemplateElement
	{
		private var _nestedElements : Array;
		
		public function MixedContent(){
			super();
			_nestedElements = [];
		}
		
		public function addElement(element : TemplateElement) : void{
			if(element){
				_nestedElements.push(element);
				element.parent = this;
			}
		}
		
		public override function accept(env:Environment):void{
			for each(var element : TemplateElement in _nestedElements){
				element.accept(env);
			}
		}
		
		public override function getCanonicalForm():String{
			var result : String;
			for each(var element : TemplateElement in _nestedElements){
				result += element.getCanonicalForm();
			}
			return result;
		}	
	}
}