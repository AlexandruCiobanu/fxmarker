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
	import com.fxmarker.Environment;
	import com.fxmarker.dataModel.IDataItemModel;

	public class AssignmentExpression extends Expression
	{
		protected var key : String;		
		protected var right : Expression;
		protected var operation : String;
		
		public function AssignmentExpression(key : String, right : Expression) {
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
			var leftData : IDataItemModel = env.getVariable(key);
			var rightData : IDataItemModel = right.getAsDataItem(env);
			leftData = compute(leftData, rightData);
			env.setVariable(key, leftData);
			return null;
		}
		
		protected function compute(leftData : IDataItemModel, rightData : IDataItemModel) : IDataItemModel{
			return rightData;
		}
	}
}