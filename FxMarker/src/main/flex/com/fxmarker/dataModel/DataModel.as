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
	import com.fxmarker.util.StringTokenizer;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ListCollectionView;
	
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class DataModel
	{		
		private var root : HashItemModel;
		/**
		 * 
		 * 
		 */		
		public function DataModel(){
			root = new HashItemModel(new Object());
		}
		/**
		 * 
		 * @param key
		 * @param value
		 * 
		 */		
		public function putValue(key : String, value : Object) : void{
			root.putValue(key, getModel(value));
		}
		/**
		 * 
		 * @param key
		 * @return 
		 * 
		 */		
		public function getValue(key : String) : IDataItemModel{
			var result : Object = root.getValue(key);
			return getModel(result);
		}
		
		private function getModel(data : Object) : IDataItemModel{
			if(data is IDataItemModel){
				return data as IDataItemModel;
			}
			if(data == null){
				return NullItemModel.INSTANCE;
			} 
			if (data is String ){
				return new StringItemModel(data as String);
			}
			if(data is Number){
				return new NumberItemModel(data as Number);
			}
			if(data is Date){
				return new DateItemModel(data as Date);
			}
			if(data is Dictionary || getQualifiedClassName(data) == "Object"){
				return new HashItemModel(data);
			}			
			if(data is Array || data is Vector || data is ListCollectionView){
				return new ListItemModel(data);
			}
			return new ObjectItemModel(data);
		}
	}
}