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
			register(CASE, 					CaseBlock);
			register(DEFAULT, 				CaseBlock);
			register(BREAK,					Break);
			register(IF, 					If);
			register(ELSEIF, 				ConditionalBlock);
			register(ELSE, 					ConditionalBlock);
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