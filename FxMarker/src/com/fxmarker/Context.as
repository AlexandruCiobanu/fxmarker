package com.fxmarker
{
	import flash.utils.Dictionary;
	
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class Context
	{
		private var parameterList : Dictionary;
		/**
		 * 
		 * 
		 */		
		public function Context()
		{
			parameterList = new Dictionary();
		}
		/**
		 * 
		 * @param key
		 * @param value
		 * 
		 */		
		public function addParameter(key : String, value : Object) : void{
			parameterList[key] = value;
		}
		/**
		 * 
		 * @param key
		 * @return 
		 * 
		 */		
		public function getParameter(key : String) : Object{
			return parameterList[key];
		}

	}
}