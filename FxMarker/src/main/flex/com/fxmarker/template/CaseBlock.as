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
	import com.fxmarker.template.expression.Expression;
	import com.fxmarker.template.expression.ExpressionParser;
	
	internal final class CaseBlock extends TemplateInlineElement
	{
		private var isDefault : Boolean;
		
		private var expressionBody : String;
		
		private var expression : Expression;
		
		public function CaseBlock(isDefault : Boolean){
			super();
			this.isDefault = isDefault;
			setOwnerTemplateElementType(Switch);
		}
		
		override public function accept(env : Environment) : void {
			if (_nestedBlock) {
				_nestedBlock.accept(env);
			}
		}
		
		override public function setContent(content:String):void 
		{
			if (isDefault) {
				return;
			}
			expressionBody = content;
			expression = ExpressionParser.instance.parse(content);
		}
		
		override public function getCanonicalForm():String {
			var buf : String = "";
			if (isDefault) {
				buf.concat("<#default>");
			}
			else {
				buf.concat("<#case ");
				buf.concat(expression.getCanonicalForm());
				buf.concat(">");
			}
			if (_nestedBlock != null) {
				buf.concat(_nestedBlock.getCanonicalForm());
			}
			return buf;

		}
	}
}