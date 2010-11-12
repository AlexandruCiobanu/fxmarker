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

	public class NumberConstant extends Expression
	{
		private var value : NumberItemModel;
		
		public function NumberConstant(value : Number){
			super();
			this.value = new NumberItemModel(value);
		}
		
		public override function getStringValue(env : Environment) : String{
			return value.data;
		}
		
		public override function getCanonicalForm() : String{
			return String(value.data);
		}
		
		public override function getAsDataItem(env : Environment) : IDataItemModel{
			return value;
		}
	}
}