package com.fxmarker
{
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public final class VERSION
	{
		public static function get Version() : String{
			return "1.0a";
		}
		
		public function VERSION()
		{
			throw new Error("Do not instanciate this class");
		}

	}
}