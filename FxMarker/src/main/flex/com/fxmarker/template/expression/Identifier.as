package com.fxmarker.template.expression
{
	import com.fxmarker.Environment;
	import com.fxmarker.dataModel.IDataItemModel;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal final class Identifier extends Expression
	{
		private var name : String;
		
		public function Identifier(name : String) {
			super();
			this.name = name;
		}		
		
		override public function getAsDataItem(env : Environment) : IDataItemModel {
			return env.getVariable(name);
		}
		
		override public function getCanonicalForm() : String {
			return name;
		}
	}
}