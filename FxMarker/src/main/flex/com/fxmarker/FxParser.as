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
	
	/**
	 * 
	 * @author aCiobanu
	 * 
	 */	
	public class FxParser
	{
		private static const VARIABLE_DEFINITION : String = "\\$\\{([a-zA-Z]\\w?\\.?)+\\}";
		private static const PATH_SEPARATOR : String = ".";
		/**
		 * 
		 */		
		public var context : DataModel;
		/**
		 * 
		 */		
		public var templateText : String; 
		/**
		 * 
		 * @param context
		 * @param templateText
		 * 
		 */		
		public function FxParser(context : DataModel = null, templateText : String = null)
		{
			this.context = context;
			this.templateText = templateText;
		}		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function parse() : String{
			var regex : RegExp = new RegExp(VARIABLE_DEFINITION, "g");
			var result : String = new String(templateText);
			var vars : Array = templateText.match(regex);
			for each(var contextVar : String in vars){
				var value : Object = getValue(contextVar, context);
				result = result.replace(contextVar, value);
			}
			return result;
		}		
		
		private function getValue(variable : String, context : DataModel) : Object{
			var path : String = variable.substr(2, variable.length - 3);
			var contextValue : Object = context.getValue(path);
			return contextValue;
		}
	}
}