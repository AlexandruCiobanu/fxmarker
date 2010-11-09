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
	import com.fxmarker.template.TemplateElement;
	import com.fxmarker.template.TemplateObject;
	
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
			conditionalBlock.setLocation(beginMetrics, endMetrics);
			conditionalBlock.setContent(StringUtil.trim(content));
			addElement(conditionalBlock);
		}		
		
		override public function addElement(element:TemplateElement):void {
			if (!_nestedElements) {
				_nestedElements = [];
			}
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