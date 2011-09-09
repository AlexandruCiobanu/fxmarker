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
		public function TemplateElement() {
			super();
		}
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
				element.setTemplate(template);
				if(!_nestedBlock){
					setNestedBlock(element);
				}else if(_nestedBlock is MixedContent){
					MixedContent(_nestedBlock).addElement(element);
				}else{
					var cnt : MixedContent = new MixedContent();
					cnt.setTemplate(template);
					var tmp : TemplateElement = _nestedBlock;
					setNestedBlock(cnt);
					cnt.addElement(tmp);
					cnt.addElement(element);
				}
			}			
		}
		
		protected function setNestedBlock(block : TemplateElement) : void{
			_nestedBlock = block;
			block.parent = this;
		}
	}
}