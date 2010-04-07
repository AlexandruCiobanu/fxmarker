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
		/**
		 * 
		 * 
		 */		
		public function Environment(){
			output = new Writer();
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
		 * @return 
		 * 
		 */		
		public function get output() : Writer{
			return _output;
		}
		
		public function set output(value : Writer) : void{
			if(value){
				_output = value;
			}
		}
	}
}