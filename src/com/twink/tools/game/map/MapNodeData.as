package com.twink.tools.game.map
{
	/**
	 * created by twink @ 2013-5-3 下午9:55:14
	 * <p>
	 * 地图节点信息
	 * <p>为什么地图的具体信息要包含到content变量里,而不是直接继承这个类作为小格内容的容器?2013-05-05
	 * 因为扩展性差,且对于地图本身来说,只需要知道基本信息即可,游戏阶段才关心具体内容.
	 */
	public class MapNodeData
	{
		//所在的地图
		private var _parent:MapData;
		//在map下的唯一ID
		private var _ID:String;
		
		//地图内容
		private var _content:IMapContent = null;
		
		public function MapNodeData($parent:MapData, $ID:String)
		{
			_parent = $parent;
			_ID = $ID;
		}
		
		//===============================================
		//操作接口
		//===============================================
		
		/**
		 * 清空
		 * 
		 */		
		public function clear():void
		{
			
		}
		
		//===============================================
		//设置接口
		//===============================================
		
		/**
		 * 设置地图节点的内容
		 * @param $value
		 * 
		 */		
		public function set content($value:IMapContent):void
		{
			_content = $value;
		}
		
		//===============================================
		//getter接口
		//===============================================
		
		/**
		 * 获得所在地图的引用
		 * @return 
		 * 
		 */		
		public function get parent():MapData
		{
			return _parent;
		}
		
		/**
		 * 其中包含的地图内容
		 * @return 
		 * 
		 */		
		public function get content():IMapContent
		{
			return _content;
		}
		
		/**
		 * 该节点对于所在地图的唯一ID
		 * @return 
		 * 
		 */		
		public function get ID():String
		{
			return _ID;
		}
	}
}