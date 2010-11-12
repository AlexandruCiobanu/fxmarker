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
package com.fxmarker.template
{
	import flash.net.registerClassAlias;
	import flash.utils.getQualifiedClassName;

	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public final class TemplateFactory
	{
		public static const IF : String = "if";
		public static const ELSEIF : String = "elseif";
		public static const ELSE : String = "else";
		public static const FOREACH : String = "foreach";
		public static const LIST : String = "list";
		public static const COMMA_SEPARATED_LIST : String = "csList";
		public static const COMMENT : String = "comment";
		public static const INTERPOLATION : String = "interpolation";
		public static const TEXT : String = "text";
		public static const SWITCH : String = "switch";
		public static const CASE : String = "case";
		public static const DEFAULT : String = "default";
		public static const BREAK : String = "break";
		
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
			register(SWITCH, 				Switch);
			register(CASE, 					CaseBlock, false);
			register(DEFAULT, 				CaseBlock, true);
			register(BREAK,					Break);
			register(IF, 					If);
			register(ELSEIF, 				ConditionalBlock, false);
			register(ELSE, 					ConditionalBlock, false);
		}
		
		private function register(name : String, clasz : Class, ...args) : void{
			map[name] = new Holder(clasz, args);
			registerClassAlias(getQualifiedClassName(clasz), clasz);
		}
		/**
		 * 
		 * @param name
		 * @return 
		 * 
		 */		
		public function getInstance(name : String, begin : Metrics, end : Metrics) : TemplateElement{
			if(name == null || name.length == 0){
				throw new Error("Empty name not allowed when creating template element instance");
			}
			var holder : Holder = map[name];
			if(!holder){
				throw new Error("No template element is registered with the name <<" + name + ">>");
			}
			return instantiate(holder, begin, end);
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
					if(map[key].toString() == className){
						return key;
					}
				}
			}
			return "";
		}
		
		private function instantiate(holder : Holder, begin : Metrics, end : Metrics) : TemplateElement {
			var instance : TemplateElement;
			if (holder.args && holder.args.length > 0) {
				switch (holder.args.length) 
				{
					case 1:
						instance = TemplateElement(new holder.TemplateClass(holder.args[0]));
						break;
					case 2:
						instance = TemplateElement(new holder.TemplateClass(holder.args[0], holder.args[1]));
						break;
					case 3:					
						instance = TemplateElement(new holder.TemplateClass(holder.args[0], holder.args[1], holder.args[2]));
						break;
				}
			}else {
				instance = TemplateElement(new holder.TemplateClass());
			}
			if (instance) {
				instance.setLocation(begin, end);
			}
			return instance;
		}
	}
}