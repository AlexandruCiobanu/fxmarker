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
	import flexunit.framework.Assert;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Alexutz
	 */
	public class StateWalkerTest
	{		
		[Test(description="This test validates the transition map used by the state machine to parse template content text. Transition triggers and end states are matched against a known content.")]
		public function performTransitionMapTest() : void {
			var templateString : Array = buildTemplateStringList();
			var states : Array = buildExpectedStateList();
			
			Assert.assertEquals("Arrays not equal length", states.length, templateString.length);
			var transitionMap : StateTransitionMap = new StateTransitionMap(new StateWalker());
			for (var i : int = 0; i < templateString.length; i++) {
				transitionMap.evaluate(templateString[i]);
				Assert.assertEquals("State mismatch on line " + i + " <<" + templateString[i] + ">>", 
					getQualifiedClassName(states[i]), getQualifiedClassName(transitionMap.currentState));
			}
		}
		
		private function buildTemplateStringList() : Array {
			return [
					"this is common text",				// 1
					"${",								// 2
					"interpolationName.var1.var3",		// 3
					"}",								// 4
					"some more text",					// 5
					"<#",								// 6
					"list iterator in params",			// 7
					">",								// 8
					"${",								// 9
					"secondInterpolation",				//10
					"}",								//11
					"<#",								//12
					"csList directive in directives",	//13
					"/>",								//14
					"bla",								//15
					"</#",								//16
					"directiveName",					//17
					">"									//18			
			];
		}
		
		private function buildExpectedStateList() : Array {
			return[
				StateText,					// 1
				StateInterpolation,			// 2
				StateInterpolation,			// 3
				StateText,					// 4
				StateText,					// 5
				StateDirectiveHead,			// 6
				StateDirectiveHead,			// 7
				StateText,					// 8
				StateInterpolation,			// 9
				StateInterpolation,			//10
				StateText,					//11
				StateDirectiveHead,			//12
				StateDirectiveHead,			//13
				StateText,					//14
				StateText,					//15
				StateDirectiveTail,			//16
				StateDirectiveTail,			//17
				StateText					//18
			];
		}
	}
}