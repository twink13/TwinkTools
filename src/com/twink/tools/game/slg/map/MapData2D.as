package com.twink.tools.game.slg.map
{
	import com.twink.tools.game.map.MapData;

	/**
	 * created by twink @ 2013-5-3 下午9:50:33
	 * <p>
	 * 二维地图信息 继承 地图信息
	 */
	public class MapData2D extends MapData
	{
		//地图的宽高 单位:格
		private var _width:int = 0;
		private var _height:int = 0;
		
		public function MapData2D()
		{
			super();
		}
		
		//===============================================
		//getter接口
		//===============================================
		
		/**
		 * 地图宽格子数
		 * @return
		 * 
		 */		
		public function get width():int
		{
			return _width;
		}
		
		/**
		 * 地图高格子数
		 * @return 
		 * 
		 */		
		public function get hight():int
		{
			return _height;
		}
	}
}