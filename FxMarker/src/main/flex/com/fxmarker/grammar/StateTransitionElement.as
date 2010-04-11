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
				return Utils.endsWith(content, condition as String);
			}
			return false;
		}
	}
}