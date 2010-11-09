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
package com.fxmarker.template.expression 
{
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.Environment;
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
				if (getQualifiedClassName(leftItem) != getQualifiedClassName(rightItem)) {
					throw new Error("Cannot perform comparison because operands have different types.");
				}
				innerValidate(leftItem, rightItem);
			}
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