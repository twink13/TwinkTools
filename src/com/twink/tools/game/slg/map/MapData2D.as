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
		//操作接口
		//===============================================
		
		/**
		 * 二维地图初始化
		 * @param $width 地图总宽
		 * @param $height 地图总高
		 * 
		 */		
		public function setUp($width:int, $height:int):void
		{
			_width = $width;
			_height = $height;
			
			for ( var i:int = 0; i < $width; i++ )
			{
				for ( var j:int = 0; j < $height; j++ )
				{
					//x:i y:j
					var nodeID:String = i + "_" + j;
					var node:MapNodeData2D = new MapNodeData2D(this, nodeID);
					node.position.setPosition(i, j);//初始化位置
					
					this.addNode(node);
				}
			}
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
		
		/**
		 * 通过位置信息获得节点
		 * @param $x
		 * @param $y
		 * @return 
		 * 
		 */		
		public function getNodeByXY($x:int, $y:int):MapNodeData2D
		{
			return this.getNodeByID($x + "_" + $y) as MapNodeData2D;
		}
		
		/**
		 * 获得周边节点
		 * @return 
		 * 
		 */		
		public function getAround($x:int, $y:int):Array
		{
			var result:Array = [];
			
			result.push(this.getNodeByXY($x, $y-1));//上
			result.push(this.getNodeByXY($x-1, $y));//左
			result.push(this.getNodeByXY($x, $y+1));//下
			result.push(this.getNodeByXY($x+1, $y));//右
			
			return result;
		}
	}
}