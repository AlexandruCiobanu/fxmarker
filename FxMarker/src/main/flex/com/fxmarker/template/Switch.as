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
	import com.fxmarker.template.expression.EqualsExpression;
	import com.fxmarker.template.expression.Expression;
	import com.fxmarker.template.expression.ExpressionParser;
	
	import mx.utils.StringUtil;

	/**
	 * Usage:<br/>
	 * <#switch expression><br/>
	 * <#case expression or constant><br/>
	 * 			... content<br/>
	 * 			<#break> //optional<br/>
	 *  <#default><br/>
	 * 			...content<br/>
	 * </#switch> <br/>
	 * @author Alexutz
	 * 
	 */	
	internal final class Switch extends TemplateElement
	{
		private var testExpression : String;
		
		private var expression : Expression;
		
		private var defaultCase : CaseBlock;
		
		public function Switch(){
			super();
		}
		
		override public function setContent(content : String):void {
			testExpression = StringUtil.trim(content);
			expression = ExpressionParser.instance.parse(testExpression);
		}		
		
		override public function addElement(element : TemplateElement) : void {
			if (!_nestedElements) {
				_nestedElements = [];
			}
			if (element is CaseBlock) {
				if(CaseBlock(element).isDefault){
					defaultCase = element as CaseBlock;
				}
				_nestedElements.push(element);
			}else if(_nestedElements.length > 0){
				CaseBlock(_nestedElements[_nestedElements.length - 1]).addElement(element);
			}
		}
		
		override public function accept(env : Environment) : void {
			super.accept(env);
			try {
				var processedCase : Boolean;
				var processCase : Boolean;
				for each(var caseBlock : CaseBlock in _nestedElements){
					processCase = false;					
					if(processedCase){
						processCase = true;
					}else if(!caseBlock.isDefault){
						var comparison : EqualsExpression = new EqualsExpression(caseBlock.getExpression(), expression);
						processCase = comparison.isTrue(env);
					}
					if(processCase){
						env.visit(caseBlock);
						processedCase = true;
					}
					
				}				
				if (!processedCase && defaultCase != null) {
					env.visit(defaultCase);
				}
			}catch (error : BreakError) {
				//do nothing
			}
		}
		
		public override function getCanonicalForm():String{
			var form : String = "<#switch " + expression.getCanonicalForm() + ">";
			for each(var caseBlock : CaseBlock in _nestedElements){
				if(caseBlock.isDefault){
					continue;
				}
				form += caseBlock.getCanonicalForm();
			}
			if(defaultCase){
				form += defaultCase.getCanonicalForm();
			}
			form += "</#switch>";
			return form;
		}
	}
}