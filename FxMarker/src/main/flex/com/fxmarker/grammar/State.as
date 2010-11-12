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
package com.fxmarker.grammar
{
	import com.fxmarker.template.Metrics;
	import com.fxmarker.template.TemplateElement;
	
	[ExcludeClass]
	/**
	 * Base class representing the State of the machine. It holds references to a begin and end metric aswell 
	 * as to the template element. The state provides two methods which need to be implemented by subclasses
	 * <code>onStateEnter()</code> and <code>onStateExit(input : String) : TemplateElement</code>.
	 * @author Alexutz
	 * 
	 */	
	internal class State
	{
		/**
		 * Get the start metrics
		 */
		public var begin : Metrics;
		/**
		 * Get the end metrics
		 */
		public var end : Metrics;
		
		protected var _element : TemplateElement;
		
		protected var walker : StateWalker;
		/**
		 * Constructor
		 * @param	walker reference to the state machine executor
		 */
		public function State(walker : StateWalker){
			this.walker = walker;
		}
		/**
		 * Get the template element represented by this state. The scope of the element is between 
		 * the state enter and state exit events. After the state machine exits the current state
		 * the element referenced is nulled.
		 * @return TemplateElement instance
		 * @see TemplateElement
		 */
		public function get element() : TemplateElement{
			return _element;
		}
		/**
		 * Method called when the state machine enters the current state.
		 * You can instanciate the template element if there are no variations due to internal fields.
		 */
		internal function onStateEnter() : void{			
		}
		/**
		 * Method called when the state machine exits the current state. Here you generally configure the
		 * template element according to the input text provided.
		 * @param	containedText input recorded from the state enter to the state exit. Usually this input is passed to the element the state holds 
		 * @return TemplateElement instance
		 */
		internal function onStateExit(containedText : String) : TemplateElement{
			//perform item cleanup
			var item : TemplateElement = element;
			_element = null;
			return item;
		}
	}
}