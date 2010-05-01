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
	internal class If extends TemplateElement
	{
		public function If(begin : Metrics, end : Metrics)
		{
			super(begin, end);
		}
		
		override public function setContent(content:String):void 
		{
			var conditionalBlock : ConditionalBlock = new ConditionalBlock(false, beginMetrics, endMetrics);
			conditionalBlock.setContent(content);
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
		
		override public function accept(env:Environment) : void {
			super.accept(env);
		}
	}
}