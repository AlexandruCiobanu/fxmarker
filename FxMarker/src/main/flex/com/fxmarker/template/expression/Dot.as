package com.fxmarker.template.expression
{
	import com.fxmarker.Environment;
	import com.fxmarker.dataModel.IDataItemModel;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class Dot extends Expression
	{
		private var target : Expression;
		
		private var key : String;
		
		public function Dot(target : Expression, key : String) {
			super();			
			this.target = target;
			this.key = key;
		}
		
		override public function getAsDataItem(env : Environment) : IDataItemModel {
			var left : IDataItemModel = target.getAsDataItem(env);
			if (target) {
				
			}
			return null;
		}
		
		override public function getCanonicalForm() : String {
			return target.getCanonicalForm() + "." + key;
		}
	}
}