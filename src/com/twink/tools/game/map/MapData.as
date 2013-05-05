package com.twink.tools.game.map
{
	import flash.utils.Dictionary;

	/**
	 * created by twink @ 2013-5-3 下午8:52:05
	 * <p>
	 * 地图信息
	 */
	public class MapData
	{
		//节点列表
		protected var _nodes:Array = [];
		//节点索引表 key:节点ID value:节点
		private var _nodesDic:Dictionary = new Dictionary();
		
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
			if ( this.getNodeByID($node.ID) )
			{
				//该ID已经存在
				return;
			}
			_nodes.push($node);
			_nodesDic[$node.ID] = $node;
		}
		
		/**
		 * 清空
		 * 
		 */		
		public function clear():void
		{
			var size:int = _nodes.length;
			for ( var i:int = 0; i < size; i++ )
			{
				var node:MapNodeData = _nodes[i];
				node.clear();//每个节点清空
			}
			_nodes = [];
			_nodesDic = new Dictionary();
		}
		
		//===============================================
		//查询接口
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
		
		/**
		 * 查找一个ID对应的节点
		 * @param $ID 节点ID
		 * @return 
		 * 
		 */		
		public function getNodeByID($ID:String):MapNodeData
		{
			return _nodesDic[$ID];
		}
		
		/**
		 * 获得包含全部的节点的数组
		 * @return 
		 * 
		 */		
		public function nodeList():Array
		{
			return _nodes;
		}
	}
}