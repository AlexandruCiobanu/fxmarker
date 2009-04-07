package com.fxmarker.reader
{
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	internal class DefaultDataProvider implements IDataProvider
	{
		/**
		 * 
		 */		
		public static const TYPE : String = "default";
		
		{
			DataProviderFactory.instance.registerProvider(TYPE, DefaultDataProvider);
		}
		/**
		 * 
		 * 
		 */		
		public function DefaultDataProvider()
		{
			//TODO: implement function
		}
		/**
		 * 
		 * @see IReader#type() 
		 * 
		 */
		public function get type():Object
		{
			//TODO: implement function
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