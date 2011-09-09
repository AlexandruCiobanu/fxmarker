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
	
	import mx.utils.StringUtil;
	
	internal class If extends TemplateElement
	{
		public function If()
		{
			super();
		}
		
		override public function setContent(content:String):void 
		{
			var conditionalBlock : ConditionalBlock = new ConditionalBlock(true);
			conditionalBlock.setTemplate(template);
			conditionalBlock.setLocation(beginMetrics, endMetrics);
			conditionalBlock.setContent(StringUtil.trim(content));
			addElement(conditionalBlock);
		}		
		
		override public function addElement(element:TemplateElement):void {
			if (!_nestedElements) {
				_nestedElements = [];
			}
			element.setTemplate(template);
			if (element is ConditionalBlock) {
				_nestedElements.push(element);
			}else{
				ConditionalBlock(_nestedElements[_nestedElements.length - 1]).addElement(element);
			}
		}
		
		override public function accept(env : Environment) : void {
			for each(var block : ConditionalBlock in _nestedElements) {
				if (block.condition == null || block.condition.isTrue(env)) {
					env.visit(block);
					return;
				}
			}
		}
		
		override public function getCanonicalForm() : String 
		{
			var buf : String = "";
			for each(var block : ConditionalBlock in _nestedElements) {
				buf = buf.concat(block.getCanonicalForm());
			}
			buf = buf.concat("</#if>");
			return buf;
		}
	}
}