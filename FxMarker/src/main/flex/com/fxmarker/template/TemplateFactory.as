package com.fxmarker.template
{
	import com.fxmarker.error.GrammarError;
	
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
			return instance;
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
		}
		
		private function registerTemplates() : void{
			map = new Object();
			map[COMMENT] = Comment;
			map[INTERPOLATION] = Interpolation;
			map[TEXT] = TextBlock;
			map[LIST] = List;
			map[FOREACH] = List;
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
				var clasz : Class = getDefinitionByName(getQualifiedClassName(instance)) as Class;
				for(var key : * in map){
					if(map[key] == clasz){
						return key;
					}
				}
			}
			return "";
		}
	}
}