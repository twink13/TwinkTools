package com.twink.tools.game.map
{
	/**
	 * created by twink @ 2013-5-3 下午8:52:05
	 * <p>
	 * 地图信息
	 */
	public class MapData
	{
		//节点列表
		protected var _nodes:Array = [];
		
		public function MapData()
		{
		}
		
		//===============================================
		//操作接口
		//===============================================
		
		/**
		 * 增加一个节点 测试用
		 * @param $node 地图节点
		 * 
		 */		
		public function addNode($node:MapNodeData):void
		{
			_nodes.push($node);
		}
		
		//===============================================
		//getter接口
		//===============================================
		
		/**
		 * 获得一个地图上的节点
		 * @param $index 节点所在位置
		 * @return 目标节点
		 * 
		 */		
		public function getNodeAt($index:int):MapNodeData
		{
			if ( $index < 0 || $index >= _nodes.length )
			{
				//非法位置 要不要报警
				return null;
			}
			return _nodes[$index];
		}
	}
}