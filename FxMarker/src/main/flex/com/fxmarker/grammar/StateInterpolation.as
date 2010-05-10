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
	import com.fxmarker.template.Interpolation;
	import com.fxmarker.template.TemplateElement;
	import com.fxmarker.template.TemplateFactory;
	
	[ExcludeClass]
	/**
	 * State representing an interpolation (${expression}).
	 * @author Alexutz
	 * 
	 */
	internal final class StateInterpolation extends State
	{
		public function StateInterpolation(walker : StateWalker)
		{
			super(walker);
		}
		
		internal override function onStateEnter() : void{
			//do nothing here			
		}
		
		internal override function onStateExit(containedText : String) : TemplateElement {
			_element = TemplateFactory.instance.getInstance(TemplateFactory.INTERPOLATION, begin, end);
			element.setContent(containedText);
			return super.onStateExit(containedText);
		}
	}
}