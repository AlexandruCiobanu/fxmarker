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
package com.fxmarker.template.expression
{
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.dataModel.NumberItemModel;

	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class DivisionAssignment extends AssignmentExpression
	{
		public function DivisionAssignment(key:Expression, right:Expression){
			super(key, right);
		}
	
		protected override function compute(leftData : IDataItemModel, rightData : IDataItemModel) : IDataItemModel{
			if(leftData is NumberItemModel && rightData is NumberItemModel){
				return new NumberItemModel(NumberItemModel(leftData).data / NumberItemModel(rightData).data);
			}
			//TODO Better error handling
			throw new Error("Wrong data to be computed. Only numbers can be used for division");
		}
	}
}