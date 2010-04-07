package com.fxmarker.grammar
{
	import com.sc8pe.parsers.gold.engine.Grammar;
	/**
	 * 
	 * @author Alexutz
	 * 
	 */	
	internal final class FxMGrammar extends Grammar
	{
		[Embed(source="/com/fxmarker/grammar/FreeMarkerTemplateTables.xml", mimeType="application/octet-stream")]
		private static var GrammarSource : Class;
		
		public function FxMGrammar()
		{
			super(getGrammarData());
		}
		
		private function getGrammarData() : XML{
			var xml : XML = new XML(new GrammarSource());
			return xml;
		}
	}
}