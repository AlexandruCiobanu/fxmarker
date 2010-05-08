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
	
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class DataModel extends Node
	{
		/**
		 * 
		 */		
		public static const PATH_DELIMITER : String = ".";
		/**
		 * 
		 * 
		 */		
		public function DataModel(){ }
		/**
		 * 
		 * @param key
		 * @param value
		 * 
		 */		
		public function putValue(path : String, value : Object) : void{
			var tokenizer : StringTokenizer = getTokens(path);
			var node : Node = this;
			while(tokenizer.hasNext()){
				var subPath : String = tokenizer.next();
				if(node.hasChild(subPath)){
					node = node.getChild(subPath);
				}else{
					node = node.addChild(subPath);
				}
			}
			if(node){
				node.data = value;
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
		public function getValue(path : String) : Object{
			var tokenizer : StringTokenizer = getTokens(path);
			var result : Object = this;
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
				return Node(result).data;
			}
			return result;
		}
		
		private function getTokens(path : String) : StringTokenizer{
			return new StringTokenizer(PATH_DELIMITER, path);
		}
	}
}