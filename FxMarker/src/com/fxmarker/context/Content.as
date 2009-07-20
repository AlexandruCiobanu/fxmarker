package com.fxmarker.context
{
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	use namespace flash_proxy;
	
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class Content extends Proxy
	{
		protected var _data : Object;
		/**
		 * 
		 * 
		 */		
		public function Content()
		{
		}
		
		public function get data() : *{
			return _data;
		}
		
		public function set data(value : *) : void{
			_data = value;
		}
		
		/**
	     *  @private
	     *  Attempts to call getItemAt(), converting the property name into an int.
	     */
	    override flash_proxy function getProperty(name:*):*
	    {
	        if (name is QName)
	            name = name.localName;
			return _data ? _data[name] : null;
	    }	    
	    /**
	     *  @private
	     *  This is only a readOnly repository of teh data so no need to call setters 
	     */
	    override flash_proxy function setProperty(name:*, value:*):void { }	    
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
	
	        return _data && _data.hasOwnProperty(name); 
	    }	
	    
	    protected var _properties:Array; // array of object's properties
	    /**
	     *  @private
	     */
		override flash_proxy function nextNameIndex(index:int):int {
			// initial call
			if (index == 0) {
				_properties = new Array();
				for (var x:* in _data) {
					_properties.push(x);
				}
			}
			
			if (index < _properties.length) {
				return index + 1;
			} else {
				return 0;
			}
		}
		/**
	     *  @private
	     */
		override flash_proxy function nextName(index:int):String {
			return _properties[index - 1];
		}
	    /**
	     *  @private
	     */
	    override flash_proxy function nextValue(index:int):*
	    {
	        return _data ? _data[_properties[index-1]] : null;
	    }	
	    /**
	     *  @private
	     *  Any methods that can't be found on this class shouldn't be called,
	     *  so return null
	     */
	    override flash_proxy function callProperty(name:*, ... rest):*
	    {
	        return null;
	    }	
	}
}