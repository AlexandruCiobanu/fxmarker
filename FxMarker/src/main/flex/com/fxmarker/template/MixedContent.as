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
	public class MixedContent extends TemplateElement
	{		
		public function MixedContent()
		{
			super();
			_nestedElements = [];
		}
		
		public override function addElement(element : TemplateElement) : void{
			if(element){
				_nestedElements.push(element);
				element.parent = this.parent;
				element.setTemplate(template);
			}
		}
		
		public override function accept(env:Environment):void{
			for each(var element : TemplateElement in _nestedElements){
				element.accept(env);
			}
		}
		
		public override function getCanonicalForm():String{
			var result : String = "";
			for each(var element : TemplateElement in _nestedElements){
				result += element.getCanonicalForm();
			}
			return result;
		}	
	}
}