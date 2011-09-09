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
package com.fxmarker.dataModel 
{
	/**
	 * ...
	 * @author Alexutz
	 */
	public class HashItemModel extends DataItemModel
	{
		
		public function HashItemModel(data : *) {
			super(data);
		}
		
		public function getValue(key : String) : IDataItemModel{
			return data != null && Object(data).hasOwnProperty(key) ? wrapper.wrap(data[key]) : NullItemModel.INSTANCE;
		}	
		
		public function putValue(key : String, value : Object) : void{
			if(data != null){
				data[key] = value;
			}
		}
	}
}