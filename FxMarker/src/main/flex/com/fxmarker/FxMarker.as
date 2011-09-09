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
	import com.fxmarker.template.Template;
	import com.fxmarker.template.TemplateParser;
	
	/**
	 * The main access point for the Flex Template Engine.
	 * Defines an easily accesible instance but does not restrict the usage to a singleton.
	 * @author aCiobanu
	 * 
	 */	
	public class FxMarker
	{
		private static var ref : FxMarker = new FxMarker();
		/**
		 * 
		 * @return 
		 * 
		 */		
		public static function get instance() : FxMarker{
			return ref;
		}
		/**
		 * 
		 */		
		private var parser : TemplateParser;
		/**
		 * Constructor 
		 * 
		 */		
		public function FxMarker() {
			parser = new TemplateParser();
		}
		/**
		 * 
		 * @param source
		 * @param config
		 * @return 
		 * 
		 */					
		public function getTemplate(source : String, config : Configuration = null) : Template{
			var template : Template = parser.parse(source, config);
			return template;
		}
	}
}