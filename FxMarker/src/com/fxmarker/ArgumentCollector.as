package com.fxmarker
{
	import flash.utils.Dictionary;
	
	import mx.utils.StringUtil;
	/**
	 * 
	 * @author aCiobanu
	 * 
	 */	
	internal class ArgumentCollector
	{
		/**
		 * 
		 */		
		public var overrideExisting : Boolean;
		
		private var _context : Context;
		/**
		 * 
		 * 
		 */		
		public function ArgumentCollector()
		{
			_context = new Context();
		}
		/**
		 * 
		 * @param key
		 * @param value
		 * 
		 */		
		public function addArgument(key : String, value : Object) : void{
			validate(key, value);
			_context.addParameter(key, value);
		}
		/**
		 * 
		 * @param xml
		 * 
		 */		
		public function parseFromXml(xml : XML) : void{
			
		}
		/**
		 * 
		 * 
		 */		
		public function parseFromProperties() : void{
			
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get context() : Context{
			return _context;
		}
		
		private function validate(key : String, value : Object) : void{
			
			if(key == null || StringUtil.trim(key) == ""){
				throw new Error("Key cannot be null, empty or whitespace");
			}
			
			if(!overrideExisting && context.getParameter(key)){
				throw new Error("A value already exists for key " + key + ".\nIf you wish to override existing values, set the overrideExisting flag to true.");
			}
			
			if(value == null){
				throw new Error("Value cannot be null for key " + key);
			}
		}
	}
}