package com.fxmarker
{
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public final class VERSION
	{
		/**
		 * 
		 * @return 
		 * 
		 */		
		public static function get Version() : String{
			return "1.0a";
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public static function get Name() : String{
			return "FxMarker";
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public static function get Link() : String{
			return "http://code.google.com/p/fxmarker";
		}
		/**
		 * 
		 * 
		 */		
		public function VERSION()
		{
			throw new Error("Do not instanciate this class");
		}

	}
}