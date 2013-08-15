package com.twink.tools.component
{
	import com.twink.tools.data.DataCell;
	import com.twink.tools.message.Messager;
	
	import flash.display.DisplayObject;

	/**
	 * created by twink @ 2013-8-10 下午2:47:22
	 * <p>
	 * 组件类
	 */
	public class Component extends Messager
	{
		//UI对应显示对象的存储容器
		private var _displayData:DataCell = new DataCell(null);
		
		public function Component()
		{
			super();
		}
		
		/**
		 * 关联资源
		 * @param $display 关联的资源
		 * 
		 */		
		public function relate($display:DisplayObject):void
		{
			if ( this.related )
			{
				this.unrelate();
			}
			_displayData.value = $display;
		}
		
		/**
		 * 取消关联
		 * 
		 */		
		public function unrelate():void
		{
			_displayData.value = null;
		}
		
		/**
		 * 查询是否已关联
		 * @return 
		 * 
		 */		
		public function get related():Boolean
		{
			return _displayData.value != null;
		}
		
		/**
		 * 获得正在关联的资源
		 * @return 
		 * 
		 */		
		public function get display():DisplayObject
		{
			return _displayData.value as DisplayObject;
		}
	}
}