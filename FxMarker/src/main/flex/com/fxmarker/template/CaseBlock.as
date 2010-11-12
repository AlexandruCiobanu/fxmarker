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
	
	import mx.utils.StringUtil;
	
	internal final class CaseBlock extends TemplateInlineElement
	{
		private var _isDefault : Boolean;
		
		private var expressionBody : String;
		
		private var expression : Expression;
		
		public function CaseBlock(isDefault : Boolean){
			super();
			this._isDefault = isDefault;
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
			expressionBody = StringUtil.trim(content);
			expression = ExpressionParser.instance.parse(expressionBody);
		}
		
		override public function getCanonicalForm():String {
			var buf : String = "";
			if (isDefault) {
				buf = buf.concat("<#default>");
			}
			else {
				buf = buf.concat("<#case ");
				buf = buf.concat(expression.getCanonicalForm());
				buf = buf.concat(">");
			}
			if (_nestedBlock != null) {
				buf = buf.concat(_nestedBlock.getCanonicalForm());
			}
			return buf;

		}
		
		internal function getExpression() : Expression{
			return expression;
		}
		
		internal function get isDefault() : Boolean{
			return _isDefault;
		}
	}
}