package com.fxmarker.dataModel 
{
	/**
	 * ...
	 * @author Alexutz
	 */
	public class StringItemModel extends DataItemModel
	{
		public static const EMPTY : StringItemModel = new StringItemModel("");
		
		public function StringItemModel(data : String) {
			super(data);			
		}
		
		override public function set data(value:*):void { }
	}
}