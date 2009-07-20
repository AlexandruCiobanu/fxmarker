package com.fxmarker
{
	import com.fxmarker.context.Context;
	
	import flash.utils.Dictionary;
	
	/**
	 * 
	 * @author aCiobanu
	 * 
	 */	
	public class FxParser implements IParser
	{
		private static const VARIABLE_DEFINITION : String = "\\$\\{([a-zA-Z]\\w?\\.?)+\\}";
		private static const PATH_SEPARATOR : String = ".";
		/**
		 * 
		 */		
		public var context : Context;
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
		public function FxParser(context : Context = null, templateText : String = null)
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
		
		private function getValue(variable : String, context : Context) : Object{
			var path : String = variable.substr(2, variable.length - 3);
			var contextValue : Object = context.getValue(path);
			return contextValue;
		}
	}
}