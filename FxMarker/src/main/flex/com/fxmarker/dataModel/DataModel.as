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
		/**
		 * 
		 */		
		public static const PATH_DELIMITER : String = ".";
		
		private var root : Node;
		/**
		 * 
		 * 
		 */		
		public function DataModel(){
			root = new Node();
		}
		/**
		 * 
		 * @param key
		 * @param value
		 * 
		 */		
		public function putValue(path : String, value : Object) : void{
			var tokenizer : StringTokenizer = getTokens(path);
			var node : Node = root;
			while(tokenizer.hasNext()){
				var subPath : String = tokenizer.next();
				if(node.hasChild(subPath)){
					node = node.getChild(subPath);
				}else{
					node = node.addChild(subPath);
				}
			}
			if(node){
				node.data = getModel(value);
			}else{
				//shouldn't be here. Throw an error
				throw new Error("Internal error for setting path <<" + path + ">>. Unable to determine target node.");
			}
		}
		/**
		 * 
		 * @param key
		 * @return 
		 * 
		 */		
		public function getValue(path : String) : IDataItemModel{
			var tokenizer : StringTokenizer = getTokens(path);
			var result : Object = root;
			while(tokenizer.hasNext() && result){
				var subPath : String = tokenizer.next();
				if(result is Node){
					if((result as Node).hasChild(subPath)){
						result = (result as Node).getChild(subPath);
					}else{
						result = (result as Node).data;
					}
				}
				
				if(result && !(result is Node)){
					if(result.hasOwnProperty(subPath)){
						result = result[subPath];
					}else{
						result = null;
					}
				}
			}
			if(result is Node){
				result = Node(result).data;
			}
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
		
		private function getTokens(path : String) : StringTokenizer{
			return new StringTokenizer(PATH_DELIMITER, path);
		}
	}
}