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
	public class TemplateElement extends TemplateObject
	{
		public static const WHITESPACE : String = " ";
		
		protected var _parent : TemplateElement;
		
		protected var _nestedBlock : TemplateElement;
		
		protected var _nestedElements : Array;
		/**
		 * 
		 * 
		 */		
		public function TemplateElement(){}
		/**
		 * 
		 * @param env
		 * @return 
		 * 
		 */		
		public function accept(env : Environment) : void{}
		
		internal function get parent() : TemplateElement{
			return _parent;
		}
		
		internal function set parent(value : TemplateElement) : void{
			_parent = value;
		}
		
		public function addElement(element : TemplateElement) : void{
			if(element){
				if(!_nestedBlock){
					setNestedBlock(element);
				}else if(_nestedBlock is MixedContent){
					MixedContent(_nestedBlock).addElement(element);
				}else{
					var cnt : MixedContent = new MixedContent();
					cnt.addElement(_nestedBlock);
					cnt.addElement(element);
					setNestedBlock(cnt);
				}
			}			
		}
		
		protected function setNestedBlock(block : TemplateElement) : void{
			_nestedBlock = block;
			block.parent = this;
		}
	}
}