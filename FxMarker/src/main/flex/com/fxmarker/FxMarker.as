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
		private var dataModel : DataModel;
		/**
		 * 
		 */		
		private var parser : TemplateParser;
		/**
		 * 
		 */		
		private var template : Template;
		/**
		 * Constructor 
		 * 
		 */		
		public function FxMarker(){
			dataModel = new DataModel();
			parser = new TemplateParser();
		}
		/**
		 * 
		 * @param source
		 * 
		 */		
		public function loadTemplate(source : String) : void{
			template = parser.parse(source);
			dataModel.clear();
		}
		/**
		 * 
		 * @param path
		 * @param value
		 * 
		 */		
		public function putValue(path : String, value : Object) : void{
			dataModel.putValue(path, value);
		}
		/**
		 * 
		 * 
		 */		
		public function clearDataModel() : void{
			dataModel.clear();
		}
		/**
		 * 
		 * 
		 */		
		public function generate() : void{
		}
	}
}