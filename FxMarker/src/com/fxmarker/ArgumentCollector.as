package com.fxmarker
{
	import com.fxmarker.context.Context;
	import com.fxmarker.reader.IDataProvider;
	
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
		
		private var _reader : IDataProvider;
		
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
		 * @return 
		 * 
		 */		
		public function get reader() : IDataProvider{
			return reader;
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set reader(value : IDataProvider) : void{
			context.clear();
			_reader = value;
			if(_reader){
				reader.iterate(addArgument);
			}
		}
		/**
		 * 
		 * @param key
		 * @param value
		 * 
		 */		
		public function addArgument(key : String, value : Object) : void{
			validate(key, value);
			_context.putValue(key, value);
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
			
			if(!overrideExisting && context.getValue(key)){
				throw new Error("A value already exists for key " + key + ".\nIf you wish to override existing values, set the overrideExisting flag to true.");
			}
			
			if(value == null){
				throw new Error("Value cannot be null for key " + key);
			}
		}
	}
}