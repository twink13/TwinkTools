package com.twink.tools.library
{
	public interface ILibrary
	{
		/**
		 * 增加一个条目
		 * @param $ID 编号
		 * @param $data 值
		 * 
		 */		
		function add($ID:String, $data:*):void
			
		/**
		 * 清除一个条目
		 * @param $ID 要清除的编号
		 * 
		 */			
		function remove($ID:String):void
			
		/**
		 * 全部清除
		 * 
		 */			
		function clear():void
		
		/**
		 * 查询是否存在条目
		 * @param $ID 条目编号
		 * @return 
		 * 
		 */			
		function hasID($ID:String):Boolean
		
		/**
		 * 通过编号查找条目 如果不存在则返回null
		 * @param $ID 条目编号
		 * @return 条目对应值
		 * 
		 */			
		function getDataByID($ID:String):*
	}
}