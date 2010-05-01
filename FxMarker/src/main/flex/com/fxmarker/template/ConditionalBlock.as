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
	internal final class ConditionalBlock extends TemplateInlineElement
	{
		private var isEndingElse : Boolean;
		
		private var expression : String;
		
		public function ConditionalBlock(isEndingElse : Boolean, begin : Metrics, end : Metrics)
		{
			super(begin, end);
			this.isEndingElse = isEndingElse;
			setOwnerTemplateElementType(If);
		}
		
		override public function setContent(content:String):void {
			if (isEndingElse) {
				return;
			}
			expression = content;
		}
		
		override public function accept(env:Environment):void {
			
		}
	}
}