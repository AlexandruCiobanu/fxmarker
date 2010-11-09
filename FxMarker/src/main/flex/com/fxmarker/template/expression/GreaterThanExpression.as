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
	import com.fxmarker.dataModel.DateItemModel;
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.dataModel.NumberItemModel;
	import com.fxmarker.dataModel.StringItemModel;

	/**
	 * ...
	 * @author Alexutz
	 */
	internal class GreaterThanExpression extends ComparisonExpression
	{		
		public function GreaterThanExpression(left : Expression, right : Expression) {
			super(left, right);			
		}
		
		override protected function compute(leftItem : IDataItemModel, rightItem : IDataItemModel) : Boolean {
			return leftItem.data > rightItem.data;
		}
		
		override protected function innerValidate(leftItem : IDataItemModel, rightItem : IDataItemModel) : void {
			if (leftItem is DateItemModel || leftItem is NumberItemModel || leftItem is StringItemModel) {
				return;
			}
			throw new Error("Model type not allowed in a comparison. Only dates, numbers and strings are allowed.");
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + ExpressionSign.GREATER_THAN + right.getCanonicalForm();
		}		
	}
}