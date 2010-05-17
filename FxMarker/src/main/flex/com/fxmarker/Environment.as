/**
 *   FxMarker - a template based content generator for Flex and Air applications 
 *   Copyright (C) 2008-2010 Alex Ciobanu
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 * 
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
 package com.fxmarker
{
	import com.fxmarker.dataModel.DataModel;
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.template.ArithmeticEngine;
	import com.fxmarker.template.ILocalContext;
	import com.fxmarker.template.Template;
	import com.fxmarker.template.TemplateElement;
	import com.fxmarker.writer.Writer;
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class Environment
	{
		private var _output : Writer;
		
		private var contextStack : Array = [];
		
		private var rootDataModel : DataModel;
		
		private var template : Template;
		
		private var arithmeticEngine : ArithmeticEngine;
		/**
		 * Constructor
		 * @param	template reference to calling template
		 * @param	rootModel reference to the data model
		 * @param	output reference to the content writer
		 */		
		public function Environment(template : Template, rootModel : DataModel, output : Writer){
			this.rootDataModel = rootModel;
			this.output = output;
			this.template = template;
			arithmeticEngine = new ArithmeticEngine();
		}
		/**
		 * 
		 */
		public function process() : void {
			try {
				clear();
				visit(template.getRootElement());
			}finally {
				clear();
			}
		}
		/**
		 * 
		 * @param node
		 * 
		 */		
		public function visit(node : TemplateElement) : void{
			if(node){
				node.accept(this);
			}
		}
		/**
		 * 
		 * @param	context
		 */
		public function visitContext(context : ILocalContext) : void {
			if(context){
				pushLocalContext(context);
				context.run(this);
				popLocalContext();
			}
		}
		/**
		 * Get the value based on variable name in the local contexts stack
		 * @param	name variable name
		 * @return variable value
		 */
		public function getLocalVariable(name : String) : IDataItemModel {
			for (var i : int = contextStack.length - 1; i > -1; i--) {
				var lc : ILocalContext = ILocalContext(contextStack[i]);
				var tm : IDataItemModel = lc.getLocalVariable(name);
                if (tm != null) {
                    return tm;
                }
            }
			return null;
		}
		/**
		 * Get the value based on variable name. It will search it through global aswell as local contexts
		 * @param	name variable name
		 * @return variable value
		 */
		public function getVariable(name : String) : IDataItemModel {
			var result : IDataItemModel = getLocalVariable(name);
			return result;
		}
		/**
		 * 
		 * @return
		 */
		public function getArithmeticEngine() : ArithmeticEngine {
			return arithmeticEngine;
		}
		/**
		 * Get the output writer used by this environment to render content
		 * @return reference to the Writer instance
		 * 
		 */		
		public function get output() : Writer{
			return _output;
		}
		/**
		 * Set the output writer used to generate the content.
		 * @param value reference to the Writer instance
		 */
		public function set output(value : Writer) : void{
			if(value){
				_output = value;
			}
		}
		
		private function pushLocalContext(context : ILocalContext) : void {
			contextStack.push();
		}
		
		private function popLocalContext() : void {
			contextStack.pop();
		}
		
		private function clear() : void {
			
		}
	}
}