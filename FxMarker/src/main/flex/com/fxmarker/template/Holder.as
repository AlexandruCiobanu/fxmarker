package com.fxmarker.template
{
	import flash.utils.getQualifiedClassName;
	
	internal final class Holder {
		
		public var args : Array;
		
		private var _templateClass : Class;
		
		private var _classQualifiedName : String;
		
		public function Holder(clasz : Class, args : Array) {
			this.TemplateClass = clasz;
			this.args = args;
		}
		
		public function get TemplateClass() : Class {
			return _templateClass;
		}
		
		public function set TemplateClass(cls : Class) : void {
			_templateClass = cls;
			_classQualifiedName = getQualifiedClassName(cls);
		}
		
		public function toString() : String {
			return _classQualifiedName;
		}	
	}
}