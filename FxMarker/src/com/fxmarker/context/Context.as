package com.fxmarker.context
{
	import com.fxmarker.util.StringTokenizer;
	
	import flash.utils.Dictionary;
	
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class Context
	{
		/**
		 * 
		 */		
		public static const PATH_DELIMITER : String = ".";
		
		private var root : Node;
		
		private var parameterList : Dictionary;
		/**
		 * 
		 * 
		 */		
		public function Context()
		{
			root = new Node("root");
			parameterList = new Dictionary();
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
			while(tokenizer.hasMoreTokens()){
				var subPath : String = tokenizer.getToken();
				if(node.hasNode(subPath)){
					node = node.getNode(subPath);
				}else{
					node = node.addNode(subPath);
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
			var result : Object = root;
			while(tokenizer.hasMoreTokens() && result){
				var subPath : String = tokenizer.getToken();
				if(result is Node){
					if((result as Node).hasNode(subPath)){
						result = (result as Node).getNode(subPath);
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
		/**
		 * 
		 * 
		 */		
		public function clear() : void{
			for(var path : * in parameterList){
				delete parameterList[path];
			}
		}
		
		private function getTokens(path : String) : StringTokenizer{
			return new StringTokenizer(PATH_DELIMITER, path);
		}
	}
}