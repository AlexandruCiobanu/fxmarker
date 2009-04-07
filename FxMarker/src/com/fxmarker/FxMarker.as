package com.fxmarker
{
	import com.fxmarker.reader.IDataProvider;
	
	/**
	 * The main access point for the Flex Template Engine.
	 * Defines an easily accesible instance but does not restrict the usage to a singleton.
	 * @author aCiobanu
	 * 
	 */	
	public class FxMarker
	{
		private static var ref : FxMarker = new FxMarker();
		/**
		 * 
		 * @return 
		 * 
		 */		
		public static function get instance() : FxMarker{
			return ref;
		} 
		/**
		 * 
		 */		
		private var collector : ArgumentCollector;
		/**
		 * 
		 */	
		private var parser : FxParser;
		/**
		 * Constructor 
		 * 
		 */		
		public function FxMarker(){
			collector = new ArgumentCollector();
			parser = new FxParser();
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set dataProvider(value : IDataProvider) : void{
			collector.reader = value;
		}
		
		public function parse(template : String = null, data : IDataProvider = null) : String{
			parser.context = collector.context;
			parser.templateText = template;
			return parser.parse();
		}
	}
}