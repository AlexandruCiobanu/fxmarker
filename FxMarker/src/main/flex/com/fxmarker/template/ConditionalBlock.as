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
			if(expression){
				expression.setTemplate(template);
			}
		}
		
		override public function accept(env : Environment) : void {
			if ((!expression || expression.isTrue(env)) && _nestedBlock) {
				_nestedBlock.accept(env);
			}
		}
		
		override public function getCanonicalForm() : String {
			var buf : String = "";
			if (expression == null) {
				buf = buf.concat("<#else");
			}else if (isFirst) {
				buf = buf.concat("<#if ");
			}else {
				buf = buf.concat("<#elseif ");
			}
			if (expression != null) {
				buf = buf.concat(expression.getCanonicalForm());
			}
			buf = buf.concat(">");
			if (_nestedBlock != null) {
				buf = buf.concat(_nestedBlock.getCanonicalForm());
			}
			return buf.toString();
		}
	}
}