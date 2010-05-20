package com.fxmarker.template.expression 
{
	import com.fxmarker.dataModel.IDataItemModel;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal final class NotEqualsExpression extends EqualsExpression
	{
		public function NotEqualsExpression(left : Expression, right : Expression) {
			super(left, right);
		}
		
		override protected function compute(leftItem : IDataItemModel, rightItem : IDataItemModel) : Boolean {
			return leftItem.data != leftItem.data;
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + "!=" + right.getCanonicalForm();;
		}
	}
}