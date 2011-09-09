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
	import com.fxmarker.Configuration;
	import com.fxmarker.template.Template;
	import com.fxmarker.template.TemplateElement;
	import com.fxmarker.template.TemplateInlineElement;
	import com.fxmarker.template.expression.ExpressionParser;

	/**
	 * This class represents the state machine used to parse and compile the template file.
	 * The result of the state machine execution is a Template object configured with respect 
	 * to the provided input.
	 */
	public final class StateWalker
	{
		/**
		 * Reference to the parent stack during the state machine execution
		 */
		internal var itemsStack : Array = [];
		
		private var metrics : TemplateMetrics = new TemplateMetrics();
		
		private var transitionMap : StateTransitionMap; 
		/*
		 * Constructor
		 *
		 */		
		public function StateWalker(){
			transitionMap = new StateTransitionMap(this);
			transitionMap.addEventListener(StateTransitionEvent.STATE_ENTER, onStateEnter);
			transitionMap.addEventListener(StateTransitionEvent.STATE_EXIT, onStateExit);
		}
		/*
		 * Parse and compile the input into a Template instance
		 * @param source input text
		 * @return Template instance representing the compiled input
		 */
		public function walk(source : String, config : Configuration) : Template{
			var template : Template = new Template();
			template.configuration = config;
			if(config){
				ExpressionParser.instance.whitespaceAsSeparator = config.whiteSpaceAsSeparator;
			}
			var buffer : String = "";
			itemsStack.push(template);
			if (source && source.length > 0) {
				//normalize line feeds
				source.replace(/\r\n|\r/gm, "\n");
				var index : int = 0;
				var char : String;
				while (index < source.length) {
					char = source.charAt(index++);
					//update metrics
					metrics.handleChar(char);
					buffer += char;
					if(transitionMap.evaluate(buffer)){
						buffer = "";
					}
				}
				transitionMap.eof(buffer);
				if(itemsStack.length > 1){
					throw new Error("End tags missing. Reached end of file.");
				}
			}
			cleanup();
			return template;
		}
		/**
		 * Get the reference to the template element acting as current parent  
		 * @return the current parent template element
		 */
		internal function get parent() : Object{
			if(itemsStack && itemsStack.length > 0){
				return itemsStack[itemsStack.length - 1];
			}
			return null;
		}
		
		private function onStateEnter(event : StateTransitionEvent) : void {
			event.enterState.begin = metrics.getMetrics();
			event.enterState.onStateEnter();
		}
		
		private function onStateExit(event : StateTransitionEvent) : void {
			event.exitState.end = metrics.getMetrics();
			var ref : TemplateElement = event.exitState.onStateExit(event.content);
			if (parent is TemplateInlineElement) {
				ref = itemsStack.pop();				
			}			
			if (ref) {
				addToParent(ref);
			}
		}
		
		private function addToParent(item : TemplateElement) : void{
			if(parent is Template){
				Template(parent).addElement(item);
			}else if(parent is TemplateElement){
				TemplateElement(parent).addElement(item);
			}
		}
		
		private function cleanup() : void{
			itemsStack = [];
			//currentItem = null;
			metrics.clear();
		}
	}
}