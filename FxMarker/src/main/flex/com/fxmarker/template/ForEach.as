package com.fxmarker.template
{
	import com.fxmarker.util.StringTokenizer;
	
	import mx.utils.StringUtil;

	/**
	 * Usage: <#foreach indexName in collectionName></#foreach>
	 * @author Alexutz
	 * 
	 */	
	internal class ForEach extends List
	{
		public function ForEach(){
			super();
		}
		
		public override function setContent(content:String) : void{
			var tokenizer : StringTokenizer = new StringTokenizer(WHITESPACE, StringUtil.trim(content));
			if(tokenizer.tokenCount != 3){
				throw new Error("Error parsing ForEach. Expected 3 parameters but got " + tokenizer.tokenCount);
			}
			iteratorName = tokenizer.getToken();
			if(tokenizer.getToken() != "in"){
				throw new Error("Error parsing ForEach. Expected 'in' on second position");
			}
			listName = tokenizer.getToken();
		}
		
		public override function getCanonicalForm():String{
			var string : String = "<#foreach " + iteratorName + " in " + listName + ">";
			if(_nestedBlock){
				string += _nestedBlock.getCanonicalForm();
			}
			string += "</#foreach>";
			return string;
		}
	}
}