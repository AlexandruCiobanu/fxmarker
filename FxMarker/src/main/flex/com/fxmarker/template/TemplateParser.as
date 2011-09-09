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
	import com.fxmarker.grammar.StateWalker;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.utils.SHA256;

	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class TemplateParser
	{		
		/**
		 * 
		 * 
		 */				
		public function TemplateParser(){
		}
		
		/**
		 * 
		 * @param data
		 * @return 
		 * 
		 */				
		public function parse(data : String, configuration : Configuration) : Template{
			var walker : StateWalker = new StateWalker();
			if(configuration == null){
				configuration = new Configuration();
			}
			var template : Template = walker.walk(data, configuration);
			return template;
		}		
	}
}