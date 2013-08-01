package com.twink.tools.data
{
	/**
	 * created by twink @ 2013-7-28 下午3:43:58
	 * <p>
	 * 数值百分比数据
	 */
	public class DataCellPercentage extends DataCell
	{
		//最大值 不能为0 默认1
		private var _maxValue:int;
		
		public function DataCellPercentage($defaultCurrentVaule:int = 0, $defaultMaxVaule:int = 1)
		{
			super($defaultCurrentVaule);
			
			_maxValue = $defaultMaxVaule;
		}
		
		//=================================================================================
		//对外接口
		//=================================================================================
		
		//=================================================================================
		//设置接口
		//=================================================================================
		
		/**
		 * 设置当前值
		 * @param $value
		 * 
		 */		
		public function set currentValue($value:int):void
		{
			super.value = $value;
			//不需要刷新了 父类会做
		}
		
		/**
		 * 设置最大值
		 * @param $value
		 * 
		 */		
		public function set maxVaule($value:int):void
		{
			_maxValue = $value;
			this.update();
		}
		
		//=================================================================================
		//读取接口
		//=================================================================================
		
		/**
		 * 返回当前值
		 * 
		 */		
		public function get currentValue():int
		{
			return this.value;
		}
		
		/**
		 * 返回最大值
		 * 
		 */		
		public function get maxValue():int
		{
			return _maxValue;
		}
		
		/**
		 * 返回百分比的整数数值
		 * @return 
		 * 
		 */		
		public function get percentage():int
		{
			return (this.currentValue * 100 / this.maxValue);
		}
		
		/**
		 * 查询是否已满
		 * @return 
		 * 
		 */		
		public function get isFull():Boolean
		{
			return (this.currentValue >= this.maxValue)
		}
	}
}