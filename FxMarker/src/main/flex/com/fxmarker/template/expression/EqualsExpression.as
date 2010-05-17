package com.fxmarker.template.expression 
{
	import com.fxmarker.dataModel.BooleanItemModel;
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.Environment;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class EqualsExpression extends ComparisonExpression
	{
		public function EqualsExpression() {
			super();
		}
		
		override protected function compute(leftItem : IDataItemModel, rightItem : IDataItemModel) : Boolean {
			return leftItem.data == leftItem.data;
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + "==" + right.getCanonicalForm();
		}
	}
}