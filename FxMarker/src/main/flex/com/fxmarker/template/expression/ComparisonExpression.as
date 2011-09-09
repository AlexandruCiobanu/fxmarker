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
	import com.fxmarker.Environment;
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.dataModel.NullItemModel;
	
	import flash.utils.getQualifiedClassName;

	/**
	 * ...
	 * @author Alexutz
	 */
	internal class ComparisonExpression extends OrExpression
	{
		public function ComparisonExpression(left : Expression, right : Expression) {
			super(left, right);			
		}	
		
		override public final function isTrue(env : Environment) : Boolean {
			var leftData : IDataItemModel = left.getAsDataItem(env);
			var rightData : IDataItemModel = right.getAsDataItem(env);
			validate(leftData, rightData);
			var result : Boolean = compute(leftData, rightData);
			return result;
		}
		/**
		 * 
		 * @param	leftItem
		 * @param	rightItem
		 * @throws Exception if any of the implicated operands is invalid in type or value 
		 */
		protected final function validate(leftItem : IDataItemModel, rightItem : IDataItemModel) : void {
			if (leftItem != null && rightItem != null) {
				if (!(leftItem is NullItemModel) && !(rightItem is NullItemModel) && getQualifiedClassName(leftItem) != getQualifiedClassName(rightItem)) {
					throw new Error("Cannot perform comparison because operands have different types.");
				}	
			}
			innerValidate(leftItem, rightItem);
		}
		/**
		 * Inner validation. In this step the items are guaranteed to be non null and have the same type.
		 * Note that by default null items are allowed in a comparison expression and the compute method
		 * shouldtake into account the possibility of one or both of the items are null.<br/>
		 * Implement this method if you need further validation than the one already provided.
		 * @param	leftItem
		 * @param	rightItem
		 */
		protected function innerValidate(leftItem : IDataItemModel, rightItem : IDataItemModel) : void { }
		/**
		 * Perform the actual calculation. Implement in subclasses.<br/>
		 * At this step the items involved are guaranteed to have valid types, be null (one or both) or 
		 * be both of the same type if they are not null.
		 * @param	leftItem
		 * @param	rightItem
		 * @return
		 */
		protected function compute(leftItem : IDataItemModel, rightItem : IDataItemModel) : Boolean {
			return false;
		}
	}
}