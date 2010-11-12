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
	import com.fxmarker.dataModel.HashItemModel;
	import com.fxmarker.dataModel.IDataItemModel;

	/**
	 * ...
	 * @author Alexutz
	 */
	internal class Dot extends Expression
	{
		private var target : Expression;
		
		private var key : String;
		
		public function Dot(target : Expression, key : String) {
			super();			
			this.target = target;
			this.key = key;
		}
		
		override public function getAsDataItem(env : Environment) : IDataItemModel {
			var left : IDataItemModel = target.getAsDataItem(env);
			if (left && left is HashItemModel) {
				left = HashItemModel(left).getValue(key);
				return left;
			}
			return null;
		}
		
		override public function getCanonicalForm() : String {
			return target.getCanonicalForm() + "." + key;
		}
	}
}