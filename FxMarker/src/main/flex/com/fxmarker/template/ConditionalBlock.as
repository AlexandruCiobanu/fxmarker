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
	
	internal final class ConditionalBlock extends TemplateInlineElement
	{
		private var isFirst : Boolean;
		
		private var expressionBody : String;
		
		private var expression : Expression;
		
		public function ConditionalBlock(isFirst : Boolean)
		{
			super();
			this.isFirst = isFirst;
			setOwnerTemplateElementType(If);
		}
		
		public function get condition() : Expression {
			return expression;
		}
		
		override public function setContent(content : String) : void {
			expressionBody = content;
			expression = ExpressionParser.instance.parse(content);
		}
		
		override public function accept(env : Environment) : void {
			if ((!expression || expression.isTrue(env)) && _nestedBlock) {
				_nestedBlock.accept(env);
			}
		}
		
		override public function getCanonicalForm() : String {
			var buf : String = "";
			if (expression == null) {
				buf.concat("<#else");
			}else if (isFirst) {
				buf.concat("<#if ");
			}else {
				buf.concat("<#elseif ");
			}
			if (expression != null) {
				buf.concat(expression.getCanonicalForm());
			}
			buf.concat(">");
			if (_nestedBlock != null) {
				buf.concat(_nestedBlock.getCanonicalForm());
			}
			return buf.toString();
		}
	}
}