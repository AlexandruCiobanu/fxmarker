package com.fxmarker.reader
{
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	internal class PropertiesDataProvider implements IDataProvider
	{
		/**
		 * 
		 */		
		public static const TYPE : String = "properties";
		
		{
			DataProviderFactory.instance.registerProvider(TYPE, PropertiesDataProvider);
		}
		
		/**
		 * 
		 * 
		 */		
		public function PropertiesDataProvider()
		{
			//TODO: implement function
		}
		/**
		 * 
		 * @see IReader#type() 
		 * 
		 */
		public function get type() : Object
		{
			return TYPE;
		}
		/**
		 * 
		 * @see IReader#iterate()
		 * 
		 */	
		public function iterate(keyValueFoundHandler:Function):void
		{
			//TODO: implement function
		}
		
	}
}