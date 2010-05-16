package com.fxmarker.template.expression
{
	import com.fxmarker.Environment;
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.dataModel.BooleanItemModel;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class BooleanExpression extends Expression
	{
		
		public function BooleanExpression() {
			super();
		}
		
		override public final function getAsDataItem(env : Environment) : IDataItemModel {
			return isTrue(env) ? BooleanItemModel.TRUE : BooleanItemModel.FALSE;
		}		
	}
}