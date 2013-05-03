package com.twink.tools.game.map
{
	/**
	 * created by twink @ 2013-5-3 下午9:55:14
	 * <p>
	 * 地图节点信息
	 */
	public class MapNodeData
	{
		//所在的地图
		private var _parent:MapData = null;
		
		public function MapNodeData($parent:MapData)
		{
			_parent = $parent;
		}
		
		//===============================================
		//getter接口
		//===============================================
		
		public function get parent():MapData
		{
			return _parent;
		}
	}
}