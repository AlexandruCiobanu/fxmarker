package com.fxmarker
{
	/**
	 * 
	 * @author aCiobanu
	 * 
	 */	
	public class FxMarker
	{
		/**
		 * 
		 */		
		private var collector : ArgumentCollector;
		/**
		 * 
		 */	
		private var parser : FxParser;
		/**
		 * Constructor 
		 * 
		 */		
		public function FxMarker(){
			collector = new ArgumentCollector();
			parser = new FxParser();
		}
	}
}