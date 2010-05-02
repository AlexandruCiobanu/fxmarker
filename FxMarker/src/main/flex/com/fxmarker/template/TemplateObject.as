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
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class TemplateObject
	{
		private var _begin : Metrics;
		
		private var _end : Metrics;
		
		public function TemplateObject() { 
		}
		
		internal function setLocation(_begin : Metrics, _end : Metrics) : void {
			this._begin = _begin;
			this._end = _end;
		}
		
		public function get beginMetrics() : Metrics {
			return _begin;
		}
		
		public function get endMetrics() : Metrics {
			return _end;
		}
		
		public function getCanonicalForm() : String{
			return "";
		}
		
		public function setContent(content : String) : void{
		}
	}
}