package com.fxmarker.dataModel 
{
	/**
	 * ...
	 * @author Alexutz
	 */
	public class BooleanItemModel extends DataItemModel
	{
		public static const TRUE : BooleanItemModel = new BooleanItemModel(true);
		public static const FALSE : BooleanItemModel = new BooleanItemModel(false);
		
		private static var initialized : Boolean = false;
		
		{
			initialized = true;
		}
		
		public function BooleanItemModel(data : Boolean) {
			super(null);
			if (initialized) {
				throw new Error("Use TRUE/FALSE accessors");
			}
			super.data = data;
		}	
		
		override public final function set data(value:*):void {}
	}
}