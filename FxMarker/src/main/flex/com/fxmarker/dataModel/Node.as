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
	import flash.utils.Dictionary;
	import flash.utils.IDataInput;
	
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