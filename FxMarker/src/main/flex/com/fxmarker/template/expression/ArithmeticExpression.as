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
	import com.fxmarker.dataModel.NumberItemModel;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class ArithmeticExpression extends Expression
	{
		protected var left : Expression;		
		protected var right : Expression;
		protected var operation : String;
		
		public function ArithmeticExpression(left : Expression, right : Expression) {
			super();
			this.left = left;
			this.right = right;
		}	
		
		override public final function isTrue(env : Environment) : Boolean {
			throw new Error("Not Applicable");
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + operation + right.getCanonicalForm();
		}
		
		override public final function getAsDataItem(env : Environment) : IDataItemModel {
			var leftData : IDataItemModel = left.getAsDataItem(env);
			var rightData : IDataItemModel = right.getAsDataItem(env);
			if (leftData is NumberItemModel && rightData is NumberItemModel) {
				var data : Number = compute(NumberItemModel(leftData).getAsNumber(), NumberItemModel(rightData).getAsNumber());
				return new NumberItemModel(data);
			}
			return null;
		}
		
		protected function compute(a : Number, b : Number) : Number {
			return 0;
		}
	}
}