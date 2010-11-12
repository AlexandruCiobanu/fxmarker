/**
 *   FxMarker - a template based content generator for Flex and Air applications 
 *   Copyright 2008-2010 Alex Ciobanu
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 */
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