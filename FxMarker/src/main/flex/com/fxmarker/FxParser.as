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