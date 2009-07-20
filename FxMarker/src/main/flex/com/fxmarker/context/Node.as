package com.fxmarker.context
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
		public var data : Object;
		/**
		 * 
		 */		
		private var _name : String;
		/**
		 * 
		 */		
		private var map : Dictionary;
		/**
		 * 
		 * 
		 */		
		public function Node(name : String){
			_name = name;
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get name() : String{
			return _name;
		}
		
		public function getNode(name : String) : Node{
			return map[name] as Node;
		}
		
		public function hasNode(name : String) : Boolean{
			return map && map[name] is Node;
		}
		
		public function addNode(name : String) : Node{
			if(!name){
				throw new Error("Cannot create a node with an empty name");
			}
			if(!map){
				map = new Dictionary();
			}
			if(map[name]){
				throw new Error("A node with the name <<" + name + ">> already exists as child of node <<" + this.name + ">>");
			}
			var node : Node = new Node(name);
			map[name] = node;
			return node;
		}
	}
}