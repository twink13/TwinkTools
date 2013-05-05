package com.twink.tools.game.slg.map
{
	import com.twink.tools.data.DataCellPosition;
	import com.twink.tools.game.map.MapData;
	import com.twink.tools.game.map.MapNodeData;

	/**
	 * created by twink @ 2013-5-3 下午8:54:50
	 * <p>
	 * 地图格子信息 继承 地图节点信息
	 */
	public class MapNodeData2D extends MapNodeData
	{
		//所在位置
		private var _position:DataCellPosition = new DataCellPosition();
		
		public function MapNodeData2D($parent:MapData, $ID:String)
		{
			super($parent, $ID);
		}
		
		//===============================================
		//getter接口
		//===============================================
		
		/**
		 * 获得所在位置
		 * @return 
		 * 
		 */		
		public function get position():DataCellPosition
		{
			return _position;
		}
	}
}