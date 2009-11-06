/**
* Gold Parser engine.
* See more details on http://www.devincook.com/goldparser/
* 
* Original code is written in VB by Devin Cook (GOLDParser@DevinCook.com)
*
* This translation is done by Reggie Wilbanks (GOLDParser@sc8pe.com) 
* 
* The translation is based on the other engine translations:
* C# engine by Vladimir Morozov (vmoroz@hotmail.com)
* Delphi engine by Alexandre Rai (riccio@gmx.at)
* C# engine by Marcus Klimstra (klimstra@home.nl)
*/
package com.sc8pe.parsers.gold.engine
{	
    	
	/**
	 *  Maps integer values used for transition vectors to objects.
	 */ 
	public class ObjectMap
	{
		private var _readOnly:Boolean;
		internal var _mapProvider:MapProvider;
		
		private static const MIN_SIZE:int = 32; 
		private static const MAX_INDEX:int = 255;
		private static const MAX_ARRAY_COUNT:int = 12;
		private static const INVALID_KEY:int = int.MAX_VALUE;
				
		/**
		 * Creates a new instance of the <code>ObjectMap</code> class.
		 */
		public function ObjectMap() {
			_mapProvider = new SortedMapProvider(MIN_SIZE);
		}
		
		/**
		 * Gets the number of entries in the map.
		 */
		public function get Count():int {
			return _mapProvider.count;
		}
		
		/**
		 * Gets the read only flag.
		 */ 
		public function get ReadOnly():Boolean {
			return _readOnly;
		}
		
		/**
		 * Sets the read only flag.
		 */ 
		public function set ReadOnly(value:Boolean):void {
			if (_readOnly != value) {
				SetMapProvider(value);
				_readOnly = value;
			}	
		}
		
		/**
		 * Get the value by key
		 */
		public function getItemAt(key:int):Object {
			return _mapProvider.getItemAt(key);
		}

		/**
		 * Set the value by key
		 * 
		 * @param key The key of the item.
		 * @param value The value to set the item to.
		 */
		public function setItemAt(key:int, value:Object):void {
			_mapProvider.Add(key,value);
		}
		
		/**
		 * Returns key by index.
		 * 
		 * @param index the index of the key to retrieve.
		 */
		public function GetKey(index:int):int {
			return _mapProvider.GetEntry(index).key;
		}
		
		/**
		 * Removes entry by its key.
		 * 
		 * @param key The key of the entry to remove.
		 */
		public function Remove(key:int):void {
			return _mapProvider.Remove(key);
		}
		
		/**
		 * Add a new key and value pair.
		 * 
		 * @param key The key of the item to add.
		 * @param value The value to add.
		 */
		public function Add(key:int, value:Object):void {
			_mapProvider.Add(key,value);
		}
		
		private function SetMapProvider(readOnly:Boolean):void {
			var count:int = _mapProvider.count;
			var provider:MapProvider = _mapProvider;
			
			if (readOnly) {
				var pr:SortedMapProvider = _mapProvider as SortedMapProvider;
				if (pr.lastKey <= MAX_INDEX) {
					provider = new IndexMapProvider();
				}
				else if (count <= MAX_ARRAY_COUNT) {
					provider = new ArrayMapProvider(_mapProvider.count);
				}
				
			}
			else {
				if (!(provider is SortedMapProvider)) {
					provider = new SortedMapProvider(_mapProvider.count);
				}
			}
			if (provider != _mapProvider) {
				for (var i:int = 0; i < count; i++) {
					var entry:Entry = _mapProvider.GetEntry(i);
					provider.Add(entry.key, entry.value);
				}
				_mapProvider = provider;
			}
		}
	}
}
	import flash.utils.Dictionary;
	

class Entry
{
	internal var key:int;
	internal var value:Object;
	
	public function Entry(Key:int,Value:Object) {
		key = Key;
		value = Value;
	}	
}

/*
 * Abstract class
 */
class MapProvider
{
	import flash.errors.IllegalOperationError;
    import flash.utils.describeType;
    import flash.utils.getQualifiedClassName; 	

	internal var count:int; // Entry count in the collection.
	
    public function MapProvider(self:MapProvider) {
        if (self != this) {
            // Only a subclass can pass a valid reference to self
            throw new IllegalOperationError("This abstract class did not receive reference to self. Abstract classes cannot be instantiated directly.");
        }
       
        // These functions MUST be implemented in subclasses
        var unimplemented:Array = [getItemAt, setItemAt, GetEntry, Add];
       
        // Get the fully-qualified name the abstract class
        var abstractTypeName:String = getQualifiedClassName(MapProvider);
       
        // Get a list of all the methods declared by the abstract class
        // If a subclass overrides a function, declaredBy will contain the subclass name
        var selfDescription:XML = describeType(this);
        var methods:XMLList = selfDescription.method.(@declaredBy == abstractTypeName && unimplemented.indexOf(this[@name])>= 0);
       
        if (methods.length() > 0) {
            // We'll only get here if the function is still unimplemented
            var concreteTypeName:String = getQualifiedClassName(this);
            throw new IllegalOperationError("Function " + methods[0].@name + " from abstract class " + abstractTypeName + " has not been implemented by subclass " + concreteTypeName);
        }
    }
   
    // Implemented
    internal function Remove(key:int):void {
    	throw new IllegalOperationError();
    }
   
    // Unimplemented
	internal function getItemAt(key:int):Object { return null };
	internal function setItemAt(key:int,value:Object):void {};
    internal function GetEntry(index:int):Entry { return null };
    internal function Add(key:int,value:Object):void {};
}

class SortedMapProvider extends MapProvider
{
	private static const GROWTH:int = 32;
	
	internal var entries:Array;
	internal var lastKey:int;
	
	public function SortedMapProvider(capacity:int) {
		super(this);
		entries = new Array(capacity);
		for(var i:int=0; i != entries.length; i++) {
			entries[i] = new Entry(0,null);
		}
	}
	
	override internal function getItemAt(key:int):Object {
		var minIndex:int = 0;
		var maxIndex:int = count - 1;
		
		if (maxIndex >= 0 && key <= lastKey) {
			do {
				var midIndex:int = Math.floor((maxIndex + minIndex) / 2);
				if (key <= entries[midIndex].key) {
					maxIndex = midIndex;
				}
				else {
					minIndex = midIndex + 1;
				}
			} while (minIndex < maxIndex);
			if (key == entries[minIndex].key) {
				return entries[minIndex].value;
			}
		}
		return null;
	}
	
	override internal function GetEntry(index:int):Entry {
		return entries[index];
	}
	
	override internal function Add(key:int, value:Object):void {
		var objFound:Object = {found:false};
		var index:int = FindInsertIndex(key, objFound);

		if (objFound.found) {
			entries[index].value = value;
			return;
		}
		if (count >= entries.length) {
			var _moreEntries:Array = new Array(GROWTH);
			for(var i:int=0; i != _moreEntries.length; i++) {
				_moreEntries[i] = new Entry(0,null);
			}
			entries  = entries.concat(_moreEntries);
		}
		if (index < count) {
			entries.splice(index,0,new Entry(0,null));
			entries.splice(entries.length-1,1);
		}
		else {
			lastKey = key;
		}
		entries[index].key = key;
		entries[index].value = value;
		count++;
	}
	
	override internal function Remove(key:int):void {
		var index:int = FindIndex(key);
		if (index >= 0) {
			entries.splice(index,1);
		}
	}
	
	private function FindIndex(key:int):int {
		var minIndex:int = 0;
		if (count >0 && key <= lastKey) {
			var maxIndex:int = count - 1;
			do {
				var midIndex:int = (maxIndex + minIndex) / 2;
				if (key <= entries[midIndex].key) {
					maxIndex = midIndex;
				}
				else {
					minIndex = midIndex + 1;
				}
			} while (minIndex < maxIndex);
			if (key == entries[minIndex].key) {
				return minIndex;
			}
		}
		return -1;
	}
	
	private function FindInsertIndex(key:int, found:Object):int {
		var minIndex:int = 0;
		if (count > 0 && key <= lastKey) {
			var maxIndex:int = count - 1;
			do {
				var midIndex:int = Math.floor((maxIndex + minIndex) / 2);
				if (key <= entries[midIndex].key) {
					maxIndex = midIndex;
				}
				else {
					minIndex = midIndex + 1;
				}
			} while (minIndex < maxIndex);
			found.found = (key == entries[minIndex].key);
			return minIndex;
		}
		found.found = false;
		return count;
	}
}

class IndexMapProvider extends MapProvider
{
	private var array:Array;

	private static const MAX_INDEX:int = 255;
	
	public function IndexMapProvider() {
		super(this);
		array = new Array(MAX_INDEX + 1);
		for (var i:int = array.length; --i >=0;) {
			array[i] = Unassigned.Value;
		}
	} 
	
	override internal function getItemAt(key:int):Object {
		if (key >= array.length || key < 0) {
			return null;
		}
		return array[key];
	}
	
	override internal function GetEntry(index:int):Entry {
		var idx:int = -1;
		for (var i:int = 0; i < array.length; i++) {
			var value:Object = array[i];
			if (value != Unassigned.Value) {
				idx++;
			}
			if (idx == index) {
				return new Entry(i,value);
			}
		}
		return new Entry(0,0);
	}
	
	override internal function Add(key:int, value:Object):void {
		array[key] = value;
		count++;
	}
}

class ArrayMapProvider extends MapProvider {
	private var entries:Array;
	
	public function ArrayMapProvider(capacity:int) {
		super(this);
		entries = new Array(capacity);
	}

	override internal function getItemAt(key:int):Object {
		for (var i:int = count; --i >= 0;) {
			var entry:Entry = entries[i];
			var entryKey:int = entry.key;
			if (entryKey > key) {
				continue;
			}
			else if (entryKey == key) {
				return entry.value;
			}
			else if (entryKey < key){
				return null;
			}
		}
		return null; 
	}

	override internal function GetEntry(index:int):Entry {
		return entries[index];
	}
	
	override internal function Add(key:int, value:Object):void {
		entries[count].key = key;
		entries[count].value = value;
		count++;
	}

}

class Unassigned extends MapProvider
{
	public function Unassigned() {
		super(this);
	}
	 
	internal static const Value:Unassigned = new Unassigned();
}
		