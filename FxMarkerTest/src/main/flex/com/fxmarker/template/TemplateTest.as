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
	
	import com.fxmarker.Configuration;
	import com.fxmarker.FxMarker;
	import com.fxmarker.dataModel.DataModel;
	import com.fxmarker.dataModel.HashItemModel;
	import com.fxmarker.dataModel.ListItemModel;
	import com.fxmarker.dataModel.NumberItemModel;
	import com.fxmarker.dataModel.ObjectItemModel;
	import com.fxmarker.dataModel.StringItemModel;
	import com.fxmarker.writer.Writer;
	
	import mx.messaging.config.ConfigMap;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class TemplateTest
	{
		[Embed(source="/assets/Interface.template", mimeType="application/octet-stream")]
		private var xmlLocalizationSource : Class;
		
		[Embed(source="/assets/solution.txt", mimeType="application/octet-stream")]
		private var solution : Class;
		
		[Test]
		public function identifierTest() : void{
			var data : String = "${import}";
			var dataModel : DataModel = new DataModel();
			dataModel.putValue("import", "mx.core.UIComponent");
			var result : String = "mx.core.UIComponent";
			testComponent(data, dataModel, result); 
		}
		
		[Test]
		public function dotTest() : void{
			var data : String = "${interface.firstImport.name}";
			var dataModel : DataModel = new DataModel();
			dataModel.putValue("interface", 
				new HashItemModel({firstImport: new ObjectItemModel({name: new StringItemModel("mx.core.UIComponent")})}));
			var result : String = "mx.core.UIComponent";
			testComponent(data, dataModel, result);
		}
		
		[Test]
		public function forEachTest() : void{
			var data : String = "<#foreach import in imports>\n" + 
				"\timport ${import};</#foreach>";
			var dataModel : DataModel = new DataModel();
			dataModel.putValue("imports", new ListItemModel(
				[new StringItemModel("mx.core.UIComponent"), 
				 new StringItemModel("mx.core.Effect"), 
				 new StringItemModel("mx.core.List"), 
				 new StringItemModel("mx.containers.Canvas")]));
			var result : String = "\n\timport mx.core.UIComponent;\n" +
									"\timport mx.core.Effect;\n" +
									"\timport mx.core.List;\n" +
									"\timport mx.containers.Canvas;";
			testComponent(data, dataModel, result); 
		}
		
		[Test]
		public function listTest() : void{
			var data : String = "<#list imports as import>\n" + 
				"\timport ${import};</#list>";
			var dataModel : DataModel = new DataModel();
			dataModel.putValue("imports", new ListItemModel(
				[new StringItemModel("mx.core.UIComponent"), 
					new StringItemModel("mx.core.Effect"), 
					new StringItemModel("mx.core.List"), 
					new StringItemModel("mx.containers.Canvas")]));
			var result : String = "\n\timport mx.core.UIComponent;\n" +
				"\timport mx.core.Effect;\n" +
				"\timport mx.core.List;\n" +
				"\timport mx.containers.Canvas;";
			testComponent(data, dataModel, result);
		}
		
		[Test]
		public function csListTest() : void{
			var data : String = "<#csList member in members>${member.name} : ${member.type}</#csList>";
			var dataModel : DataModel = new DataModel();
			dataModel.putValue("members", new ListItemModel(
				[new HashItemModel({name: new StringItemModel("component"), type: new StringItemModel("mx.core.UIComponent")}), 
					new HashItemModel({name: new StringItemModel("effect"), type: new StringItemModel("mx.core.Effect")}), 
					new HashItemModel({name: new StringItemModel("list"), type: new StringItemModel("mx.core.List")}), 
					new HashItemModel({name: new StringItemModel("canvas"), type: new StringItemModel("mx.containers.Canvas")})]));
			var result : String = "component : mx.core.UIComponent, effect : mx.core.Effect, list : mx.core.List, canvas : mx.containers.Canvas";
			testComponent(data, dataModel, result);
		}
		
		[Test]
		public function switchTest() : void{
			var data : String = "<#switch value><#case \"test\">Test is the selected value<#break><#default>Nothing found</#switch>";
			var dataModel : DataModel = new DataModel();
			dataModel.putValue("value", new StringItemModel("test"));
			var result : String = "Test is the selected value";
			testComponent(data, dataModel, result);
			dataModel.putValue("value", new StringItemModel("default"));
			result = "Nothing found";
			testComponent(data, dataModel, result);
			data = "<#switch value><#case \"var\">Variable<#break><#case \"default\">default is the selected value<#case \"oau\">ouare<#break><#default>Nothing found</#switch>";
			result = "default is the selected valueouare";
			testComponent(data, dataModel, result);
		}
		
		[Test]
		public function ifelseTest() : void{
			var data : String = "<#if value==4>Value is 4<#else>The value is not 4</#if>";
			var dataModel : DataModel = new DataModel();
			dataModel.putValue("value", new NumberItemModel(4));
			var result : String = "Value is 4";
			testComponent(data, dataModel, result);
			dataModel.putValue("value", new NumberItemModel(5));
			result = "The value is not 4";
			testComponent(data, dataModel, result);
		}
		
		private function testComponent(source : String, model : DataModel, expectedResult : String, config : Configuration = null ) : void{
			var template : Template = FxMarker.instance.getTemplate(source, config);
			var canonical : String = template.getRootElement().getCanonicalForm();
			//assertThat(canonical, equalTo(source));
			var writer : Writer = new Writer();
			template.process(model, writer);
			assertThat(writer.writtenData, equalTo(expectedResult));
		}
		
		[Test]
		public function assignmentTest() : void{
			var source : String = "${test=4}";
			var template : Template = FxMarker.instance.getTemplate(source);
			var dataModel : DataModel = new DataModel();
			dataModel.putValue("test", 1);
			var writer : Writer = new Writer();
			template.process(dataModel, writer);
			assertThat(dataModel.getValue("test").data, equalTo(4));
			source = "${test+=4}";
			template = FxMarker.instance.getTemplate(source);
			template.process(dataModel, writer);
			assertThat(dataModel.getValue("test").data, equalTo(8));
			source = "${test-=2}";
			template = FxMarker.instance.getTemplate(source);
			template.process(dataModel, writer);
			assertThat(dataModel.getValue("test").data, equalTo(6));
			source = "${test*=2}";
			template = FxMarker.instance.getTemplate(source);
			template.process(dataModel, writer);
			assertThat(dataModel.getValue("test").data, equalTo(12));
			source = "${test/=3}";
			template = FxMarker.instance.getTemplate(source);
			template.process(dataModel, writer);
			assertThat(dataModel.getValue("test").data, equalTo(4));
			source = "${test%=3}";
			template = FxMarker.instance.getTemplate(source);
			template.process(dataModel, writer);
			assertThat(dataModel.getValue("test").data, equalTo(1));
		}
		
		[Test]
		public function fullTest() : void{
			var testData : String = new String(new xmlLocalizationSource());
			var dataModel : DataModel = new DataModel();
			dataModel.putValue("package", "com.axway.test");
			dataModel.putValue("name", "ILifecycleObject");
			dataModel.putValue("description", "This interface defines a lifeCycle object");
			dataModel.putValue("imports", [new StringItemModel("flash.utils.getQualifiedClassName"), 
										new StringItemModel("mx.core.UIComponent"), 
										new StringItemModel("flash.display.DisplayObject")]);
			var methods : Array = [];
			var method : Object = new HashItemModel({name: new StringItemModel("getState"), description: new StringItemModel("Retrieves the state of the object"), returnType: new StringItemModel("State")});
			methods.push(method);
			method = new HashItemModel({name: new StringItemModel("setState"), description: new StringItemModel("Sets the state of the object"), returnType: new StringItemModel("void"), 
				params: new ListItemModel([new HashItemModel({name: new StringItemModel("state"), type: new StringItemModel("State"), description: new StringItemModel("The state instance to be set")})])});
			methods.push(method);
			dataModel.putValue("methods", methods);
			
			var result : String = new String(new solution());
			testComponent(testData, dataModel, result);
			
			dataModel = new DataModel();
			dataModel.putValue("package", "com.axway.test");
			dataModel.putValue("name", "ILifecycleObject");
			dataModel.putValue("description", "This interface defines a lifeCycle object");
			dataModel.putValue("imports", ["flash.utils.getQualifiedClassName", 
				"mx.core.UIComponent", 
				"flash.display.DisplayObject"]);
			methods = [];
			method = {name: "getState", description: "Retrieves the state of the object", returnType: "State"};
			methods.push(method);
			method = {name: "setState", description: "Sets the state of the object", returnType: "void", 
				params: [{name: "state", type: "State", description: "The state instance to be set"}]};
			methods.push(method);
			dataModel.putValue("methods", methods);
			
			testComponent(testData, dataModel, result);
		}
		
		[Test]
		public function ifelseTestStringLength() : void{			
			var data : String = "<#if text.length==4>Length is 4<#else>The length is not 4</#if>";
			var dataModel : DataModel = new DataModel();
			dataModel.putValue("text", new HashItemModel("abcd"));
			var result : String = "Length is 4";
			testComponent(data, dataModel, result);
			// test empty string
			dataModel.putValue("text", new HashItemModel(""));
			result = "The length is not 4";
			testComponent(data, dataModel, result);
			
			// test null==4 => false
			dataModel.putValue("text", new HashItemModel(null));
			result = "The length is not 4";
			testComponent(data, dataModel, result);
		}
		
		[Test]
		public function testComplexExpressions() : void{
			var data : String = "<#if value!=null && value==\"4\">good<#else>bad</#if>";
			var dataModel : DataModel = new DataModel();
			dataModel.putValue("value", new StringItemModel("4"));
			var result : String = "good";
			testComponent(data, dataModel, result);
		}
		
		[Test]
		public function ifelseTestWithSpaces() : void{
			var data : String = "<#if value == 4>Value is 4<#else>The value is not 4</#if>";
			var dataModel : DataModel = new DataModel();
			dataModel.putValue("value", new NumberItemModel(4));
			var result : String = "Value is 4";
			
			var configuration : Configuration = new Configuration();
			configuration.whiteSpaceAsSeparator = true;
			
			testComponent(data, dataModel, result, configuration);
			dataModel.putValue("value", new NumberItemModel(5));
			result = "The value is not 4";
			testComponent(data, dataModel, result, configuration);
		}
		
		[Test]
		public function ifelseTestStringEmptyOrNull() : void{
			var data : String = "<#if text>String has content<#else>String empty or null</#if>";
			var dataModel : DataModel = new DataModel();
			dataModel.putValue("text", new HashItemModel("abcd"));
			var result : String = "String has content";
			testComponent(data, dataModel, result);
			// test empty string
			dataModel.putValue("text", new HashItemModel(""));
			result = "String empty or null";
			testComponent(data, dataModel, result);
			// test null==4 => false
			dataModel.putValue("text", new HashItemModel(null));
			result = "String empty or null";
			testComponent(data, dataModel, result); 
		}
		
		[Test]
		public function ifelseTestLessThan() : void{
			var data : String = "<#if value<4>Value is less<#else>The value is not less</#if>";
			var dataModel : DataModel = new DataModel();
			dataModel.putValue("value", new NumberItemModel(3));
			var result : String = "Value is less";
			testComponent(data, dataModel, result);
			dataModel.putValue("value", new NumberItemModel(5));
			result = "The value is not less";
			testComponent(data, dataModel, result);
		}
		
		[Test]
		[Ignore("This is not yet properly supported")]
		public function ifelseTestGreaterThan() : void{
			var data : String = "<#if value>4>Value is greater<#else>The value is not greater</#if>";
			var dataModel : DataModel = new DataModel();
			dataModel.putValue("value", new NumberItemModel(8));
			var result : String = "Value is greater";
			testComponent(data, dataModel, result);
			dataModel.putValue("value", new NumberItemModel(0));
			result = "The value is not greater";
			testComponent(data, dataModel, result);
		}
		
		[Test]
		public function ifelseTestStringLengthNotEqual() : void{
			var data : String = 
				"<#if text.length!=4>The length is not 4<#else>Length is 4</#if>";
			var dataModel : DataModel = new DataModel();
			dataModel.putValue("text", new HashItemModel("abcd"));
			var result : String = "Length is 4";
			testComponent(data, dataModel, result);
			dataModel.putValue("text", new HashItemModel(""));
			result = "The length is not 4";
			testComponent(data, dataModel, result);
			dataModel.putValue("text", new HashItemModel(null));
			result = "The length is not 4";
			testComponent(data, dataModel, result);
		}
	}
}