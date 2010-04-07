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
			if(useGrammarFile){
				template = parseFromGrammar(data);
			}else{
				template = parseFromStateMachine(data);
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
			return null;
		}
		
	}
}