package com.twink.tools.library
{
	import com.twink.tools.dataContainer.DataCellDic;
	import com.twink.tools.message.Messager;

	/**
	 * created by twink @ 2013-7-28 下午2:46:55
	 * <p>
	 * 资源库类
	 */
	public class Library extends DataCellDic implements ILibrary
	{
		public function Library($maxCount:int = -1)
		{
			super($maxCount);
		}
		
		public function add($ID:String, $data:*):void
		{
			super.addData($ID, $data);
		}
		
		public function remove($ID:String):void
		{
			super.delDataByID($ID);
		}
		
		public override function clear():void
		{
			super.clear();
		}
		
		public override function hasID($ID:String):Boolean
		{
			return super.hasID($ID);
		}
		
		public override function getDataByID($ID:String):*
		{
			return super.getDataByID($ID);
		}
	}
}