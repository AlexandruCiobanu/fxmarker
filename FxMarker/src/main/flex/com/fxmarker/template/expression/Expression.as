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
 package com.fxmarker.template.expression
{
	import com.fxmarker.Configuration;
	import com.fxmarker.Environment;
	import com.fxmarker.dataModel.IDataItemModel;
	import com.fxmarker.template.TemplateObject;

	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class Expression extends TemplateObject
	{
		public function Expression(){
			super();
		}
		
		public function getStringValue(env : Environment) : String{
			return getAsDataItem(env).getAsString(env.configuration);
		}		
		
		public function getAsDataItem(env : Environment) : IDataItemModel {
			return null;
		}
		
		public function isTrue(env : Environment) : Boolean {
			var item:* = getAsDataItem(env);
			return item && item.data; 
		}
		
		protected final function get configuration() : Configuration{
			return template.configuration;
		}
	}
}