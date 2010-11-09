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
	 * @author User
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