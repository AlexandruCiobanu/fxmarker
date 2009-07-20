package com.fxmarker.reader
{
	import flash.utils.Dictionary;
	
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	public class DataProviderFactory
	{
		private static var _instance : DataProviderFactory;
		/**
		 * Get the singleton instance
		 * @return 
		 * 
		 */		
		public static function get instance() : DataProviderFactory{
			if(!_instance){
				new DataProviderFactory();
			}
			return _instance;
		}
		
		private var providerMap : Dictionary;
		/**
		 * Constructor
		 * 
		 */		
		public function DataProviderFactory()
		{
			if(_instance){
				throw new Error("Do not instanciate ReaderFactory. User ReaderFactory.instance instead!");
			}
			_instance = this;
		}	
		/**
		 * 
		 * @param dataType
		 * @param clasz
		 * 
		 */		
		public function registerProvider(dataType : String, clasz : Class) : void{
			if(dataType && clasz){
				if(providerMap){
					providerMap = new Dictionary();
				}
				providerMap[dataType] = clasz;
			}
		}	
		/**
		 * 
		 * @param source
		 * @return 
		 * 
		 */		
		public function getXmlReader(source : Object) : IDataProvider{
			return getReader(XmlDataProvider.TYPE, source);
		} 
		/**
		 * 
		 * @param source
		 * @return 
		 * 
		 */		
		public function getPropertiesReader(source : Object) : IDataProvider{
			return getReader("properties", source);
		} 
		/**
		 * 
		 * @param source
		 * @return 
		 * 
		 */		
		public function getDefaultProvider(source : Dictionary) : IDataProvider{
			return getReader(DefaultDataProvider.TYPE, source);
		}		
		/**
		 * 
		 * @param type
		 * @param source
		 * @return 
		 * 
		 */		
		private function getReader(type : String, source : Object) : IDataProvider{
			var clasz : Class = providerMap[type];
			if(clasz){
				return new clasz() as IDataProvider;
			}
			throw new Error("Provider class not found for type " + type);
		}
	}
}