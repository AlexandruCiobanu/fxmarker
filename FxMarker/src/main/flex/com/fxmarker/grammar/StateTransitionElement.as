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
	import com.fxmarker.util.Utils;
	
	import flash.utils.getQualifiedClassName;
		
	[ExcludeClass]
	/**
	 * Element defining a state transition. It defines the source state, and a list of 
	 * target states with the associated transition conditions
	 * @author Alexutz
	 * 
	 */
	internal final class StateTransitionElement
	{
		/**
		 * 
		 */		
		public var source : State;
		/**
		 * 
		 */		
		public var targetStates : Array;
		/**
		 * 
		 */		
		public var conditions : Array;
		/**
		 * The content built up so far, excluding the end section that triggered the transition
		 */		
		internal var evaluatedContent : String;
		/**
		 * Constructor
		 * @param source
		 * 
		 */		
		public function StateTransitionElement(source : State){
			this.source = source;
		}
		/**
		 * 
		 * @param toState
		 * @param condition
		 * 
		 */		
		public function addTransition(toState : State, condition : Object) : void{
			validate(toState, condition);
			
			if(targetStates == null){
				targetStates = [];
				conditions = [];
			}
			
			targetStates.push(toState);
			conditions.push(condition);
		}
		/**
		 * 
		 * @param content
		 * @return 
		 * 
		 */		
		public function evaluate(content : String) : State{
			var condition : Object;
			for(var i : int = 0; i < conditions.length; i++){
				condition = conditions[i];
				if(testCondition(condition, content)){
					return targetStates[i] as State;
				}
			}
			return source;
		}
		
		private function validate(toState : State, condition : Object) : void{
			if(toState == null){
				throw new Error("The target state must be specified in order to register a state transition.");
			}
			
			var value : String = getQualifiedClassName(toState);			
			for each(var state : State in targetStates){
				if(getQualifiedClassName(state) == value){
					throw new Error("There already is a transition specified from " + String(source) + " to " + String(toState));
				}
			}
			
			value = String(condition);
			for each(var cnd : Object in conditions){
				if(String(cnd) == value){
					throw new Error("There is already a transition specified from state " + String(source) + " with the condition " + value);
				}
			}
		}
		
		private function testCondition(condition : Object, content : String) : Boolean{
			if(condition == null){
				return true;
			}
			if(condition is String){
				var result : Boolean = Utils.endsWith(content, condition as String);
				if(result){
					evaluatedContent = condition is String ? content.substring(0, content.length - String(condition).length) : content;
				}
				return result;
			}
			return false;
		}
	}
}