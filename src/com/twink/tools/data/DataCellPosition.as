package com.twink.tools.data
{
	import flash.geom.Point;

	/**
	 * created by twink @ 2013-5-5 下午5:45:55
	 * <p>
	 * 具有位置信息的数据单元
	 */
	public class DataCellPosition extends DataCell
	{
		public function DataCellPosition()
		{
			//构造时自动生成默认位置
			super(new Point(0, 0));
		}
		
		//======================================
		//setters
		//======================================
		
		/**
		 * 设定坐标位置
		 * @param $x x坐标
		 * @param $y y坐标
		 * 
		 */		
		public function setPosition($x:int, $y:int):void
		{
			this.position.x = $x;
			this.position.y = $y;
			this.update();
		}
		
		/**
		 * 设定x坐标
		 * @param $value
		 * 
		 */		
		public function set x($value:int):void
		{
			this.position.x = $value;
			this.update();
		}
		
		/**
		 * 设定y坐标
		 * @param $value
		 * 
		 */		
		public function set y($value:int):void
		{
			this.position.y = $value;
			this.update();
		}
		
		//======================================
		//getters
		//======================================
		
		/**
		 * 获得坐标Point
		 * @return 
		 * 
		 */		
		public function get position():Point
		{
			return this.value;
		}
		
		/**
		 * 获得x坐标
		 * @return 
		 * 
		 */		
		public function get x():int
		{
			return this.position.x;
		}
		
		//获得y坐标
		public function get y():int
		{
			return this.position.y;
		}
	}
}