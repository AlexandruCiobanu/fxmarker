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