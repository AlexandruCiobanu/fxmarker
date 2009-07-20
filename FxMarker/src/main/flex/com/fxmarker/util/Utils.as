package com.fxmarker.util
{
	import mx.utils.StringUtil;
	/**
	 * 
	 * @author aCiobanu
	 * 
	 */	
	public class Utils
	{
		/**
		 * 
		 * @param string
		 * @return 
		 * 
		 */		
		public static function isEmpty(string : String) : Boolean{
			return string == null || StringUtil.trim(string) == ""; 
		}
		
		public function Utils()
		{
			throw new Error("Do not instanciate Utils class.");
		}
	}
}