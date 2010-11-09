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