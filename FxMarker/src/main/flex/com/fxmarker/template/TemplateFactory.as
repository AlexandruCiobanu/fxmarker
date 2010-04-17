package com.fxmarker.template
{
	import com.fxmarker.error.GrammarError;
	
	import flash.net.registerClassAlias;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public final class TemplateFactory
	{
		public static const IF : String = "if";
		public static const FOREACH : String = "foreach";
		public static const LIST : String = "list";
		public static const COMMA_SEPARATED_LIST : String = "csList";
		public static const COMMENT : String = "comment";
		public static const INTERPOLATION : String = "interpolation";
		public static const TEXT : String = "text";
		
		private static var _instance : TemplateFactory = new TemplateFactory();
		/**
		 * 
		 * @return 
		 * 
		 */		
		public static function get instance() : TemplateFactory{
			return _instance;
		}
		
		private var map : Object;
		/**
		 * 
		 * 
		 */		
		public function TemplateFactory(){
			if(_instance){
				throw new Error("Use the static accessor instance instead")
			}
			registerTemplates();
		}
		
		private function registerTemplates() : void{
			map = new Object();
			register(COMMENT, 				Comment);
			register(INTERPOLATION, 		Interpolation);
			register(TEXT,  				TextBlock);
			register(LIST,  				List);
			register(FOREACH,  				ForEach);
			register(COMMA_SEPARATED_LIST,  CommaSeparatedList);
		}
		
		private function register(name : String, clasz : Class) : void{
			map[name] = clasz;
			registerClassAlias(getQualifiedClassName(clasz), clasz);
			trace(getQualifiedClassName(clasz));
		}
		/**
		 * 
		 * @param name
		 * @return 
		 * 
		 */		
		public function getInstance(name : String) : TemplateElement{
			if(name == null || name.length == 0){
				throw new Error("Empty name not allowed when creating template element instance");
			}
			var TemplateClass : Class = map[name];
			if(!TemplateClass){
				throw new Error("No template element is registered with the name <<" + name + ">>");
			}
			return TemplateElement(new TemplateClass());
		}
		/**
		 * 
		 * @param instance
		 * @return 
		 * 
		 */		
		public function getName(instance : TemplateElement) : String{
			if(instance){
				var className : String = getQualifiedClassName(instance);
				for(var key : * in map){
					if(getQualifiedClassName(map[key]) == className){
						return key;
					}
				}
			}
			return "";
		}
	}
}