/**
 *   FxMarker - a template based content generator for Flex and Air applications 
 *   Copyright (C) 2008-2009 Alex Ciobanu
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
	import com.fxmarker.reader.IDataProvider;
	
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
		private var collector : ArgumentCollector;
		/**
		 * 
		 */	
		private var parser : FxParser;
		/**
		 * Constructor 
		 * 
		 */		
		public function FxMarker(){
			collector = new ArgumentCollector();
			parser = new FxParser();
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set dataProvider(value : IDataProvider) : void{
			collector.reader = value;
		}
		
		public function parse(template : String = null, data : IDataProvider = null) : String{
			parser.context = collector.context;
			parser.templateText = template;
			return parser.parse();
		}
	}
}