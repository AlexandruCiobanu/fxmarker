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
	
	import com.fxmarker.FxMarker;
	import com.fxmarker.dataModel.DataModel;
	import com.fxmarker.dataModel.HashItemModel;
	import com.fxmarker.dataModel.ListItemModel;
	import com.fxmarker.dataModel.NumberItemModel;
	import com.fxmarker.dataModel.ObjectItemModel;
	import com.fxmarker.dataModel.StringItemModel;
	import com.fxmarker.writer.Writer;
	
	import flash.sampler.NewObjectSample;
	
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
		
		private function testComponent(source : String, model : DataModel, expectedResult : String) : void{
			var template : Template = FxMarker.instance.getTemplate(source);
			var canonical : String = template.getRootElement().getCanonicalForm();
			assertThat(canonical, equalTo(source));
			var writer : Writer = new Writer();
			template.process(model, writer);
			assertThat(writer.writtenData, equalTo(expectedResult));
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
			var method : HashItemModel = new HashItemModel({name: new StringItemModel("getState"), description: new StringItemModel("Retrieves the state of the object"), returnType: new StringItemModel("State")});
			methods.push(method);
			method = new HashItemModel({name: new StringItemModel("setState"), description: new StringItemModel("Sets the state of the object"), returnType: new StringItemModel("void"), 
				params: new ListItemModel([new HashItemModel({name: new StringItemModel("state"), type: new StringItemModel("State"), description: new StringItemModel("The state instance to be set")})])});
			methods.push(method);
			dataModel.putValue("methods", methods);
			
			var result : String = new String(new solution());
			
			testComponent(testData, dataModel, result);
		}
	}
}