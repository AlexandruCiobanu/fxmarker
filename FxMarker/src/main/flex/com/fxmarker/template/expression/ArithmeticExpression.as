package com.fxmarker.template.expression 
{
	import com.fxmarker.dataModel.NumberItemModel;
	import com.fxmarker.Environment;
	import com.fxmarker.dataModel.IDataItemModel;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class ArithmeticExpression extends Expression
	{
		protected var left : Expression;		
		protected var right : Expression;
		protected var operation : String;
		
		public function ArithmeticExpression(left : Expression, right : Expression) {
			super();
			this.left = left;
			this.right = right;
		}	
		
		override public final function isTrue(env : Environment) : Boolean {
			throw new Error("Not Applicable");
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + operation + right.getCanonicalForm();;
		}
		
		override public final function getAsDataItem(env : Environment) : IDataItemModel {
			var leftData : IDataItemModel = left.getAsDataItem(env);
			var rightData : IDataItemModel = right.getAsDataItem(env);
			if (leftData is NumberItemModel && rightData is NumberItemModel) {
				var data : Number = compute(NumberItemModel(leftData).getAsNumber(), NumberItemModel(rightData).getAsNumber());
				return new NumberItemModel(data);
			}
			return null;
		}
		
		protected function compute(a : Number, b : Number) : Number {
			return 0;
		}
	}
}