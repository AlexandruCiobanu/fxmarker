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
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.dataModel.ListItemModel;
	import com.fxmarker.dataModel.NumberItemModel;
	import com.fxmarker.error.TemplateElementConfigurationError;
	import com.fxmarker.util.Iterator;
	import com.fxmarker.writer.Writer;

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