package com.fxmarker.grammar 
{
	import com.fxmarker.template.Metrics;
	
	/**
	 * ...
	 * @author ...
	 */
	internal class TemplateMetrics extends Metrics
	{
		
		public function TemplateMetrics() {
			super(1, 1);
		}
		
		public function newLine() : void {
			_line = 1;
			_column++;
		}
		
		public function newColumn() : void {
			_column ++;
		}
		
		public function handleChar(char : String) : void {
			if (char == "\n") {
				newLine();
			}else {
				newColumn();
			}
		}
		
		public function getMetrics() : Metrics {
			return new Metrics(_line, _column);
		}
		
		public function clear() : void {
			_line = 1;
			_column = 1;
		}		
	}

}