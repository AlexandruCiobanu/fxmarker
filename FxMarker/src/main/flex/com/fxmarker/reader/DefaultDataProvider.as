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
 package com.fxmarker.reader
{
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	internal class DefaultDataProvider implements IDataProvider
	{
		/**
		 * 
		 */		
		public static const TYPE : String = "default";
		
		{
			DataProviderFactory.instance.registerProvider(TYPE, DefaultDataProvider);
		}
		/**
		 * 
		 * 
		 */		
		public function DefaultDataProvider()
		{
			//TODO: implement function
		}
		/**
		 * 
		 * @see IReader#type() 
		 * 
		 */
		public function get type():Object
		{
			//TODO: implement function
			return TYPE;
		}
		/**
		 * 
		 * @see IReader#iterate()
		 * 
		 */	
		public function iterate(keyValueFoundHandler:Function):void
		{
			//TODO: implement function
		}		
	}
}