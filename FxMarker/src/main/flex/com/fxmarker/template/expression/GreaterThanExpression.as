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