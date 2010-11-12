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
		private var useGrammarFile : Boolean;
		
		private var templateRepository : Dictionary;
		
		/**
		 * 
		 * @param useGrammarFile
		 * 
		 */				
		public function TemplateParser(useGrammarFile : Boolean = false){
			this.useGrammarFile = useGrammarFile;
		}
		
		/**
		 * 
		 * @param data
		 * @return 
		 * 
		 */				
		public function parse(data : String) : Template{
			var bytes : ByteArray = new ByteArray();
			bytes.writeUTFBytes(data);
			var hash : String = SHA256.computeDigest(bytes)
			var template : Template = getTemplateFromCache(hash);
			if(!template){
				if(useGrammarFile){
					template = parseFromGrammar(data);
				}else{
					template = parseFromStateMachine(data);
				}
			}
			return template;
		}
		
		private function getTemplateFromCache(hash : String) : Template{
			return null;
		}
		
		private function parseFromGrammar(data : String) : Template{
			return null;
		}
		
		private function parseFromStateMachine(data : String) : Template{
			var walker : StateWalker = new StateWalker();
			return walker.walk(data);
		}
		
	}
}