package com.fxmarker.reader
{
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	internal class XmlDataProvider implements IDataProvider
	{
		/**
		 * 
		 */		
		public static const TYPE : String = "xml";
		
		{
			DataProviderFactory.instance.registerProvider(TYPE, XmlDataProvider);
		}
		
		/**
		 * Constructor
		 * 
		 */		
		public function XmlDataProvider()
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