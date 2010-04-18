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
package com.fxmarker.grammar
{
	import com.fxmarker.template.MixedContent;
	import com.fxmarker.template.Template;
	import com.fxmarker.template.TemplateElement;
	
	import flash.utils.Dictionary;

	public final class StateWalker
	{
		internal var currentItem : TemplateElement;
		internal var itemsStack : Array = [];
		
		private var transitionMap : StateTransitionMap; 
				
		public function StateWalker(){
			transitionMap = new StateTransitionMap(this);
			transitionMap.addEventListener(StateTransitionEvent.STATE_ENTER, onStateEnter);
			transitionMap.addEventListener(StateTransitionEvent.STATE_EXIT, onStateExit);
		}
		
		public function walk(source : String) : Template{
			var template : Template = new Template();
			var buffer : String = "";
			itemsStack.push(template);
			if(source && source.length > 0){
				var index : int = 0;
				while(index < source.length){
					buffer += source.charAt(index++);
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
		
		internal function get parent() : Object{
			if(itemsStack && itemsStack.length > 0){
				return itemsStack[itemsStack.length - 1];
			}
			return null;
		}
		
		private function onStateEnter(event : StateTransitionEvent) : void{
			event.currentState.onStateEnter();
		}
		
		private function onStateExit(event : StateTransitionEvent) : void{
			var ref : TemplateElement = event.currentState.onStateExit(event.content);
			addToParent(ref);
			
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
			currentItem = null;
		}
	}
}