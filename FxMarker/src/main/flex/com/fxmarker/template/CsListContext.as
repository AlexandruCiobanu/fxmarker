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
	import com.fxmarker.util.Iterator;

	/**
	 * ...
	 * @author Alexutz
	 */
	internal class CsListContext extends ListContext
	{
		
		public function CsListContext(list : IDataItemModel, iteratorName : String, nestedBlock : TemplateElement) {
			super(list, iteratorName, nestedBlock);
		}
		
		public override function run(env : Environment) : void{
			if (list) {
				var it : Iterator = list.getIterator();
				index = 0;
				while (it.hasNext()) {
					loopVar = it.next();
					index++;
					env.visit(nestedBlock);
					if(it.hasNext()){
						env.output.write(", ");
					}
				}
			}
		}
	}
}