package com.fxmarker.template.expression 
{
	import com.fxmarker.dataModel.IDataItemModel;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal final class NotEqualsExpression extends EqualsExpression
	{
		public function NotEqualsExpression() {
			super();
		}
		
		override protected function compute(leftItem : IDataItemModel, rightItem : IDataItemModel) : Boolean {
			return leftItem.data != leftItem.data;
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + "!=" + right.getCanonicalForm();;
		}
	}
}