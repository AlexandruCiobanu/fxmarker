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
	import com.fxmarker.dataModel.DataModel;
	import com.fxmarker.reader.IDataProvider;
	
	import mx.utils.StringUtil;
	/**
	 * 
	 * @author aCiobanu
	 * 
	 */	
	internal class ArgumentCollector
	{
		/**
		 * 
		 */		
		public var overrideExisting : Boolean;
		
		private var _reader : IDataProvider;
		
		private var _context : DataModel;
		/**
		 * 
		 * 
		 */		
		public function ArgumentCollector()
		{
			_context = new DataModel();
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get reader() : IDataProvider{
			return reader;
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set reader(value : IDataProvider) : void{
			context.clear();
			_reader = value;
			if(_reader){
				reader.iterate(addArgument);
			}
		}
		/**
		 * 
		 * @param key
		 * @param value
		 * 
		 */		
		public function addArgument(key : String, value : Object) : void{
			validate(key, value);
			_context.putValue(key, value);
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get context() : DataModel{
			return _context;
		}
		
		private function validate(key : String, value : Object) : void{
			
			if(key == null || StringUtil.trim(key) == ""){
				throw new Error("Key cannot be null, empty or whitespace");
			}
			
			if(!overrideExisting && context.getValue(key)){
				throw new Error("A value already exists for key " + key + ".\nIf you wish to override existing values, set the overrideExisting flag to true.");
			}
			
			if(value == null){
				throw new Error("Value cannot be null for key " + key);
			}
		}
	}
}