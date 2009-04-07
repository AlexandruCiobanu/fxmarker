package com.fxmarker.reader
{
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public interface IDataProvider
	{
		/**
		 * 
		 * @return 
		 * 
		 */		
		function get type() : Object;
		/**
		 * 
		 * @param keyValueFoundHandler
		 * 
		 */		
		function iterate(keyValueFoundHandler : Function) : void;		
	}
}