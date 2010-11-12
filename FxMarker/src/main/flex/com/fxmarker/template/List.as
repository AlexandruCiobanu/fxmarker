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
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.template.expression.Expression;
	import com.fxmarker.template.expression.ExpressionParser;
	import com.fxmarker.util.StringTokenizer;
	
	import mx.utils.StringUtil;

	/**
	 * Usage: <#list collectionName as indexName></#list>
	 * @author Alexutz
	 * 
	 */	
	internal class List extends TemplateElement
	{
		protected var iteratorName : String;
		
		protected var listExpression : Expression;
		
		public function List()
		{
			super();
		}
		
		public override function accept(env:Environment):void{
			var list : IDataItemModel = listExpression.getAsDataItem(env);
			var context : ListContext = new ListContext(list, iteratorName, _nestedBlock);
			env.visitContext(context);
		}
		
		public override function setContent(content:String) : void{
			var tokenizer : StringTokenizer = new StringTokenizer(WHITESPACE, StringUtil.trim(content));
			if(tokenizer.count != 3){
				throw new Error("Error parsing List. Expected 3 parameters but got " + tokenizer.count);
			}
			listExpression = ExpressionParser.instance.parse(tokenizer.next());
			if(tokenizer.next() != "as"){
				throw new Error("Error parsing List. Expected 'as' on second position");
			}
			iteratorName = tokenizer.next();
		}	
		
		public override function getCanonicalForm():String{
			var string : String = "<#list " + listExpression.getCanonicalForm() + " as " + iteratorName + ">";
			if(_nestedBlock){
				string += _nestedBlock.getCanonicalForm();
			}
			string += "</#list>";
			return string;
		}
	}
}