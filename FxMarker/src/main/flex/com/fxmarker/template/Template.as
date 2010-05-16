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
 package com.fxmarker.template
{
	import com.fxmarker.dataModel.DataModel;
	import com.fxmarker.Environment;
	import com.fxmarker.writer.Writer;
	/**
	 * 
	 */
	public class Template
	{
		private var root : TemplateElement;
		
		public function Template(){}
		/**
		 * 
		 * @param	element
		 */
		public function addElement(element : TemplateElement) : void{
			if(element){
				if(!root){
					root = element;
				}else if(root is MixedContent){
					MixedContent(root).addElement(element);
				}else{
					var cnt : MixedContent = new MixedContent();
					cnt.addElement(root);
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