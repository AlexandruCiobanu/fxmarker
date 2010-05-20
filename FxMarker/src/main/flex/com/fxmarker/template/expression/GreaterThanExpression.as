package com.fxmarker.template.expression 
{
	import com.fxmarker.dataModel.DateItemModel;
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.dataModel.NumberItemModel;
	import com.fxmarker.dataModel.StringItemModel;
	import com.fxmarker.Environment;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class GreaterThanExpression extends ComparisonExpression
	{		
		public function GreaterThanExpression(left : Expression, right : Expression) {
			super(left, right);			
		}
		
		override protected function compute(leftItem : IDataItemModel, rightItem : IDataItemModel) : Boolean {
			return false;
		}
		
		override protected function innerValidate(leftItem : IDataItemModel, rightItem : IDataItemModel) : void {
			if (leftItem is DateItemModel || leftItem is NumberItemModel || leftItem is StringItemModel) {
				return;
			}
			throw new Error("Model type not allowed in a comparison. Only dates, numbers and strings are allowed.");
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + ExpressionSign.GREATER_THAN + right.getCanonicalForm();
		}		
	}
}