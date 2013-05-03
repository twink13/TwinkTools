package com.twink.tools.data
{
	/**
	 * 维护人：twink 2013-5-3 - 今
	 * <p>
	 * 可存储旧数据的数据单元
	 */
	public class DataCellMemory extends DataCell
	{
		//上次的数据 默认空
		private var _oldValue:* = null;
		
		public function DataCellMemory($defaultVaule:* = null)
		{
			super($defaultVaule);
		}
		
		/**
		 * 设置数据并派发事件
		 * @param v
		 * 
		 */		
		public override function set value(v:*):void
		{
			_oldValue = super.value;//记录上一次的数据
			super.value = v;
		}
		
		/**
		 * 销毁
		 * 
		 */		
		public override function destory():void
		{
			_oldValue = null;
			super.destory();
		}
		
		/**
		 * 获得上次的数据
		 */
		public function get oldValue():*
		{
			return _oldValue;
		}
	}
}