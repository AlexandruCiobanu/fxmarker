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
 package com.fxmarker
{
	import com.fxmarker.dataModel.DataModel;
	import com.fxmarker.dataModel.HashItemModel;
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.dataModel.ObjectWrapper;
	import com.fxmarker.template.ILocalContext;
	import com.fxmarker.template.Template;
	import com.fxmarker.template.TemplateElement;
	import com.fxmarker.writer.Writer;
	
	import mx.utils.StringUtil;

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
		
		private var wrapper : ObjectWrapper;
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
			this.wrapper = new ObjectWrapper();
		}
		
		public function get configuration() : Configuration{
			return template.configuration;
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
			var tm : Object;
			for (var i : int = contextStack.length - 1; i > -1; i--) {
				var lc : ILocalContext = ILocalContext(contextStack[i]);
				tm = lc.getLocalVariable(name);
                if (tm != null) {
                    break;
                }
            }
			if(tm == null){
				tm = rootDataModel.getValue(name);
			}
			return wrapper.wrap(tm);
		}
		/**
		 * Get the value based on variable name. It will search it through global aswell as local contexts
		 * @param	name variable name
		 * @return variable value
		 */
		public function getVariable(name : String) : IDataItemModel {
			var result : IDataItemModel = getLocalVariable(StringUtil.trim(name));
			return result;
		}
		
		public function setVariable(name : String, value : IDataItemModel) : void{
			rootDataModel.putValue(name, value);
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
			contextStack.push(context);
		}
		
		private function popLocalContext() : void {
			contextStack.pop();
		}
		
		private function clear() : void {
			
		}
	}
}