package com.twink.tools.data
{
	/**
	 * 维护人：twink 2013-5-7 - 今
	 * <p>
	 * 标签数据单元
	 */
	public class DataCellTags extends DataCell
	{
		public function DataCellTags($defaultVaule:Array = null)
		{
			super($defaultVaule);
			
			//如果为空就置成空数组
			if ( !this.value )
			{
				this.value = [];
			}
		}
		
		/**
		 * 获得全部标签
		 * @return 
		 * 
		 */		
		public function get tags():Array
		{
			return this.value;
		}
		
		/**
		 * 增加一个标签
		 * @param $tag
		 * 
		 */		
		public function addTag($tag:String):void
		{
			if ( this.hasTag($tag) )
			{
				//已经有了
				return;
			}
			this.tags.push($tag);
			this.update();
		}
		
		/**
		 * 查询是否存在标签
		 * @param $tag 标签名
		 * @return 
		 * 
		 */		
		public function hasTag($tag:String):Boolean
		{
			var index:int = this.tags.indexOf($tag);
			if ( index == -1 )
			{
				return false;
			}
			return true;
		}
	}
}