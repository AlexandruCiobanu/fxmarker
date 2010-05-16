package com.fxmarker.template.expression 
{
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.Environment;
	/**
	 * ...
	 * @author Alexutz
	 */
	internal class ComparisonExpression extends OrExpression
	{
		public function ComparisonExpression() {
			super();			
		}	
		
		override public final function isTrue(env:Environment) : Boolean {
			var leftData : IDataItemModel = left.getAsDataItem(env);
			var rightData : IDataItemModel = right.getAsDataItem(env);
			validate(leftData, rightData);
			var result : Boolean = compute(leftData, rightData);
			return result;
		}
		/**
		 * 
		 * @param	leftItem
		 * @param	rightItem
		 * @throws Exception if any of the implicated operands is invalid in type or value 
		 */
		protected function validate(leftItem : IDataItemModel, rightItem : IDataItemModel) : void {
			
		}
		/**
		 * 
		 * @param	leftItem
		 * @param	rightItem
		 * @return
		 */
		protected function compute(leftItem : IDataItemModel, rightItem : IDataItemModel) : Boolean {
			return false;
		}
	}
}