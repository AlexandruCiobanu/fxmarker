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
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.dataModel.ListContent;
	import com.fxmarker.dataModel.ListItemModel;
	import com.fxmarker.Environment;
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
		
		protected var listName : String;
		
		public function List()
		{
			super();
		}
		
		public override function accept(env:Environment):void{
			var list : IDataItemModel = env.getLocalVariable(listName);
			var context : ListContext = new ListContext(list, iteratorName, _nestedBlock);
			env.visitContext(context);
		}
		
		public override function setContent(content:String) : void{
			var tokenizer : StringTokenizer = new StringTokenizer(WHITESPACE, StringUtil.trim(content));
			if(tokenizer.count != 3){
				throw new Error("Error parsing List. Expected 3 parameters but got " + tokenizer.count);
			}
			listName = tokenizer.next();
			if(tokenizer.next() != "as"){
				throw new Error("Error parsing List. Expected 'as' on second position");
			}
			iteratorName = tokenizer.next();
		}	
		
		public override function getCanonicalForm():String{
			var string : String = "<#list " + listName + " as " + iteratorName + ">";
			if(_nestedBlock){
				string += _nestedBlock.getCanonicalForm();
			}
			string += "</#list>";
			return string;
		}
	}
}