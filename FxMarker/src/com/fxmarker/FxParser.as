package com.fxmarker
{
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
		
		private var values : Dictionary = new Dictionary();
		
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
			if(values[variable]){
				return values[variable];	
			}
			var stripped : String = variable.substr(2, variable.length - 3);
			var pathElements : Array = stripped.split(PATH_SEPARATOR);
			var contextVar : String = pathElements[0] as String;
			var contextValue : Object = context.getParameter(contextVar);
			if(!contextValue){
				throw ParseError.getContextVarNotFoundError(contextVar, variable);
			}
			if(pathElements.length == 1){
				values[variable] = contextValue;
				return contextValue;
			}
			var field : String;
			for(var i : int = 1; i< pathElements.length; i++){
				field = pathElements[i];
				if(contextValue.hasOwnProperty(field)){
					contextValue = contextValue[field];
					if(!contextValue && i < pathElements.length - 1){
						throw ParseError.getNullPathError(contextVar, field, variable);
					}
				}else{
					throw ParseError.getPropertyNotDefinedError(contextVar, field, variable);
				}
			}
			values[variable] = contextValue;
			return contextValue;
		}
	}
}