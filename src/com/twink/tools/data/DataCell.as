package com.twink.tools.data
{
	import com.twink.tools.message.Messager;
	
	/**
	 * 维护人：twink 2013-5-3 - 今
	 * <p>
	 * 数据单元
	 */
	public class DataCell extends Messager
	{
		/**
		 * 更新事件
		 * <p>参数: DataCell自身
		 */		
		public static const UPDATE:String = "UPDATE";
		/**
		 * 数据清空事件
		 * <p>1个参数: (this:DataCell)
		 */		
		public static const CLEAR:String = "CLEAR";
		
		//存储的数据
		private var _value:*;
		
		public function DataCell( $defaultVaule:* = null)
		{
			super();
			_value = $defaultVaule;
		}
		
		/**
		 * 设置数据并派发事件
		 * @param v
		 * 
		 */		
		public function set value(v:*):void
		{
			_value = v;
			this.update();
		}
		
		/**
		 * 获得数据
		 * @return 
		 * 
		 */		
		public function get value():*
		{
			return _value;
		}
		
		/**
		 * 输出字符串形态数据
		 * @return 
		 * 
		 */		
		public function toString():String
		{
			if ( _value == null )
			{
				//不存在value
				return "null";
			}
			return _value.toString();
		}
		
		/**
		 * 销毁
		 * 
		 */		
		public function destory():void
		{
			_value = null;
		}
		
		//========================================================================
		//内部处理
		//========================================================================
		
		/**
		 * 发更新事件
		 * 
		 */		
		protected function update():void
		{
			this.send(UPDATE, this);
		}
		
		/**
		 * 发清空和更新事件
		 * 
		 */		
		protected function updateClear():void
		{
			this.send(CLEAR, this);
			this.update();
		}
	}
}