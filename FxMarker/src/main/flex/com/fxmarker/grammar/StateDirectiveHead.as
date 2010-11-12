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
package com.fxmarker.grammar
{
	import com.fxmarker.template.TemplateElement;
	import com.fxmarker.template.TemplateFactory;
	
	[ExcludeClass]
	/**
	 * State representing a directive begin element tag (<#directive params>).
	 * @author Alexutz
	 * 
	 */	
	internal final class StateDirectiveHead extends State
	{
		public function StateDirectiveHead(walker : StateWalker)
		{
			super(walker);
		}
		
		internal override function onStateEnter() : void{
			//do nothing here
		}
		
		internal override function onStateExit(containedText : String) : TemplateElement{
			var index : int = containedText.indexOf(" ");
			var elementName : String = index > -1 ? containedText.substring(0, index) : containedText; 
			var content : String = index > -1 ? containedText.substring(index) : "";	
			
			_element = TemplateFactory.instance.getInstance(elementName, begin, end);
			_element.setContent(content);
			walker.itemsStack.push(_element);			
			_element = null;
			return super.onStateExit(containedText);
		}
	}
}