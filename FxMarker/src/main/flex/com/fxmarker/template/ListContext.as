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
	import com.fxmarker.dataModel.ListItemModel;
	import com.fxmarker.dataModel.NumberItemModel;
	import com.fxmarker.util.Iterator;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class ListContext implements ILocalContext
	{
		protected var loopVar : IDataItemModel;
		protected var loopVarName : String;
		protected var index : int;
		protected var list : ListItemModel;
		protected var nestedBlock : TemplateElement;
		
		public function ListContext(list : IDataItemModel, iteratorName : String, nestedBlock : TemplateElement) {
			if(list is ListItemModel){
				this.list = list as ListItemModel;
				loopVarName = iteratorName;
				this.nestedBlock = nestedBlock;
			}
		}
		
		/* INTERFACE com.fxmarker.template.ILocalContext */
		
		public function run(env : Environment) : void{
			if (list) {
				var it : Iterator = list.getIterator();
				index = 0;
				while (it.hasNext()) {
					loopVar = it.next();
					index++;
					env.visit(nestedBlock);
				}
			}
		}
		
		public function getLocalVariable(name : String) : * {
			if (name == loopVarName) {
				return loopVar;
			}
			if (name == loopVarName + "_index") {
				return new NumberItemModel(index);
			}
			return null;
		}		
	}
}