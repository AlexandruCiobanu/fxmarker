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

	public class AssignmentExpression extends Expression
	{
		protected var key : Expression;		
		protected var right : Expression;
		protected var operation : String;
		
		public function AssignmentExpression(key : Expression, right : Expression) {
			super();
			this.key = key;
			this.right = right;
		}
		
		override public final function isTrue(env : Environment) : Boolean {
			throw new Error("Not Applicable");
		}
		
		override public function getCanonicalForm() : String {
			return key + operation + right.getCanonicalForm();
		}
		
		override public final function getAsDataItem(env : Environment) : IDataItemModel {
			var _key : String = key.getCanonicalForm();
			var leftData : IDataItemModel = env.getVariable(_key);
			var rightData : IDataItemModel = right.getAsDataItem(env);
			leftData = compute(leftData, rightData);
			env.setVariable(_key, leftData);
			return NullItemModel.INSTANCE;
		}
		
		protected function compute(leftData : IDataItemModel, rightData : IDataItemModel) : IDataItemModel{
			return rightData;
		}
	}
}