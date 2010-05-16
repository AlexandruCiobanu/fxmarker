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
 package com.fxmarker.dataModel
{
	import flash.utils.flash_proxy;
	
	import mx.collections.IList;
	use namespace flash_proxy;
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	internal class ListContent extends Content
	{
		/**
		 * 
		 * 
		 */		
		public function ListContent(){
			super();
		}
		
		public override final function set data(value : *) : void{
			if(!value || value is Array || value is IList){
				_data = value;
			}else{
				throw new Error("Not a list");
			}
		}		
		/**
	     *  @private
	     *  Attempts to call getItemAt(), converting the property name into an int.
	     */
	    override flash_proxy function getProperty(name:*):*
	    {
	        if (name is QName)
	            name = name.localName;
	
	        var index:int = -1;
	        try
	        {
	            // If caller passed in a number such as 5.5, it will be floored.
	            var n:Number = parseInt(String(name));
	            if (!isNaN(n))
	                index = int(n);
	        }
	        catch(e:Error) // localName was not a number
	        {
	        }
	
	        if (index == -1)
	        {
	            throw new Error("");
	        }
	        else
	        {
	            return getItemAt(index);
	        }
	    }
	    /**
	     *  @private
	     *  This is an internal function.
	     *  The VM will call this method for code like <code>"foo" in bar</code>
	     *  
	     *  @param name The property name that should be tested for existence.
	     */
	    override flash_proxy function hasProperty(name:*):Boolean
	    {
	        if (name is QName)
	            name = name.localName;
	
	        var index:int = -1;
	        try
	        {
	            // If caller passed in a number such as 5.5, it will be floored.
	            var n:Number = parseInt(String(name));
	            if (!isNaN(n))
	                index = int(n);
	        }
	        catch(e:Error) // localName was not a number
	        {
	        }
	
	        if (index == -1)
	            return false;
	
	        return index >= 0 && index < length;
	    }	
	    /**
	     *  @private
	     */
	    override flash_proxy function nextNameIndex(index:int):int
	    {
	        return index < length ? index + 1 : 0;
	    }	    
	    /**
	     *  @private
	     */
	    override flash_proxy function nextName(index:int):String
	    {
	        return (index - 1).toString();
	    }	    
	    /**
	     *  @private
	     */
	    override flash_proxy function nextValue(index:int):*
	    {
	        return getItemAt(index - 1);
	    }
	    
	    private function getItemAt(index : int) : *{
	    	if(_data is Array){
	    		var list : Array = _data as Array;
	    		if(index > 0 && list && index < list.length){
	    			return list[index]; 
	    		}
	    	}else if(_data is IList){
	    		return IList(_data).getItemAt(index);
	    	}
	    }	
	}
}