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
	import com.fxmarker.template.TemplateElement;
	import com.fxmarker.template.TemplateFactory;
	import com.fxmarker.template.TextBlock;
	
	[ExcludeClass]
	/**
	 * State representing a text body. This is the default state. 
	 * @author Alexutz
	 * 
	 */
	internal final class StateText extends State
	{
		public function StateText(walker : StateWalker)
		{
			super(walker);
		}
		
		internal override function onStateEnter() : void{
			//do nothing here
		}
		
		internal override function onStateExit(containedText : String) : TemplateElement {
			if (containedText) {
				_element = TemplateFactory.instance.getInstance(TemplateFactory.TEXT, begin, end);
				_element.setContent(containedText);
			}else{
				_element = null;
			}
			return super.onStateExit(containedText);
		}
	}
}