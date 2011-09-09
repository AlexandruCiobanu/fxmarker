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
 package com.fxmarker.template
{
	import com.fxmarker.Configuration;
	import com.fxmarker.Environment;
	import com.fxmarker.dataModel.DataModel;
	import com.fxmarker.writer.Writer;

	/**
	 * 
	 */
	public class Template
	{
		private var root : TemplateElement;
		private var _configuration : Configuration;
		
		public function Template(){}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public final function get configuration() : Configuration{
			return _configuration;
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set configuration(value : Configuration) : void{
			_configuration = value;
		}

		/**
		 * 
		 * @param	element
		 */
		public function addElement(element : TemplateElement) : void{
			if(element){
				element.setTemplate(this);
				if(!root){
					root = element;
				}else if(root is MixedContent){
					MixedContent(root).addElement(element);
				}else{
					var cnt : MixedContent = new MixedContent();
					cnt.addElement(root);
					cnt.setTemplate(this);
					cnt.addElement(element);
					root = cnt;
				}
			}			
		}
		/**
		 * 
		 * @return
		 */
		public function getRootElement() : TemplateElement {
			return root;
		}
		/**
		 * Main access point for starting the template processing.
		 * @param	dataModel data model to be used when rendering the text
		 * @param	out output writer
		 */
		public function process(dataModel : DataModel, out : Writer) : void {
			new Environment(this, dataModel, out).process();
		}
	}
}