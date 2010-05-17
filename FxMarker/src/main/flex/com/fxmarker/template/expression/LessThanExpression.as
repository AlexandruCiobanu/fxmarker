package com.fxmarker.template.expression 
{
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.Environment;
	/**
	 * ...
	 * @author Alexutz
	 */
	public class LessThanExpression extends GreaterThanExpression
	{
		public function LessThanExpression() {
			super();			
		}
		
		override protected function compute(leftItem : IDataItemModel, rightItem : IDataItemModel) : Boolean {
			return false;
		}
		
		override public function getCanonicalForm() : String {
			return left.getCanonicalForm() + "<" + right.getCanonicalForm();;
		}		
	}
}