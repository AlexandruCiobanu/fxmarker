package com.fxmarker.template
{
	import com.fxmarker.Environment;

	internal class CommaSeparatedList extends ForEach
	{
		public function CommaSeparatedList(){
			super();
		}
		
		public override function accept(env:Environment):void{
			
		}
		
		public override function getCanonicalForm():String{
			var string : String = "<#csList " + iteratorName + " in " + listName + ">";
			if(_nestedBlock){
				string += _nestedBlock.getCanonicalForm();
			}
			string += "</#csList>";
			return string;
		}
	}
}