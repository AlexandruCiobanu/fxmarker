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
	import com.fxmarker.util.Utils;
	
	import flash.utils.getQualifiedClassName;
		
	[ExcludeClass]
	/**
	 * 
	 * @author User
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
		 * 
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