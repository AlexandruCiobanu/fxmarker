package com.fxmarker.template.expression 
{
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.Environment;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class GreaterThanEqualsExpression extends GreaterThanExpression
	{
		public function GreaterThanEqualsExpression(left : Expression, right : Expression) {
			super(left, right);
		}
		
		override protected function compute(leftItem : IDataItemModel, rightItem : IDataItemModel) : Boolean {
			return false;
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + ExpressionSign.GREATER_THAN_EQUALS + right.getCanonicalForm();;
		}		
	}
}