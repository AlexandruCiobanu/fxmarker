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
	import com.fxmarker.template.expression.ExpressionParser;
	import com.fxmarker.util.StringTokenizer;
	
	import mx.utils.StringUtil;

	/**
	 * Usage: <#foreach indexName in collectionName></#foreach>
	 * @author Alexutz
	 * 
	 */	
	internal class ForEach extends List
	{
		public function ForEach()
		{
			super();
		}
		
		public override function setContent(content:String) : void{
			var tokenizer : StringTokenizer = new StringTokenizer(WHITESPACE, StringUtil.trim(content));
			if(tokenizer.count != 3){
				throw new Error("Error parsing ForEach. Expected 3 parameters but got " + tokenizer.count);
			}
			iteratorName = tokenizer.next();
			if(tokenizer.next() != "in"){
				throw new Error("Error parsing ForEach. Expected 'in' on second position");
			}
			listExpression = ExpressionParser.instance.parse(tokenizer.next());
		}
		
		public override function getCanonicalForm():String{
			var string : String = "<#foreach " + iteratorName + " in " + listExpression.getCanonicalForm() + ">";
			if(_nestedBlock){
				string += _nestedBlock.getCanonicalForm();
			}
			string += "</#foreach>";
			return string;
		}
	}
}