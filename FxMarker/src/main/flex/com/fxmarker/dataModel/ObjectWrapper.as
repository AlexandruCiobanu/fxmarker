package com.fxmarker.dataModel
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ListCollectionView;

	public final class ObjectWrapper
	{
		public function ObjectWrapper(){}
		
		public function wrap(value : Object) : IDataItemModel{
			if(value is IDataItemModel){
				return value as IDataItemModel;
			}
			if(value == null){
				return NullItemModel.INSTANCE;
			} 
			if (value is String ){
				return new StringItemModel(value as String);
			}
			if(value is Number){
				return new NumberItemModel(value as Number);
			}
			if(value is Date){
				return new DateItemModel(value as Date);
			}
			if(value is Dictionary || getQualifiedClassName(value) == "Object"){
				return new HashItemModel(value);
			}			
			if(value is Array || value is Vector || value is ListCollectionView){
				return new ListItemModel(value);
			}
			return new ObjectItemModel(value);
		}
	}
}