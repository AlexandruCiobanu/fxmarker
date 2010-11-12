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
	import flash.utils.Dictionary;
	
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	internal class Node
	{
		/**
		 * 
		 */		
		private var _data : IDataItemModel;
		/**
		 * 
		 */		
		private var children : Dictionary;
		/**
		 * 
		 * 
		 */		
		public function Node(data : IDataItemModel = null){
			this.data = data;
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set data(value : IDataItemModel) : void{
			_data = value;
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get data() : IDataItemModel{
			return _data;
		}
		/**
		 * 
		 * @param name
		 * @return 
		 * 
		 */				
		public function getChild(name : String) : Node{
			return children[name] as Node;
		}
		/**
		 * 
		 * @param name
		 * @return 
		 * 
		 */		
		public function hasChild(name : String) : Boolean{
			return children && children[name] is Node;
		}
		/**
		 * 
		 * @param name
		 * @return 
		 * 
		 */		
		public function addChild(name : String, data : IDataItemModel = null) : Node{
			if(!name){
				throw new Error("Cannot create a node with an empty name");
			}
			if(!children){
				children = new Dictionary();
			}
			if(children[name]){
				throw new Error("A node with the name <<" + name + ">> already exists as child of current node");
			}
			var node : Node = new Node(data);
			children[name] = node;
			return node;
		}
		/**
		 * 
		 * 
		 */		
		public function clear() : void{
			data = null;
			for(var name : * in children){
				Node(children[name]).clear();
				delete children[name];
			}
		}
	}
}