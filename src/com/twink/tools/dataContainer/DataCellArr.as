package com.twink.tools.dataContainer
{
	/**
	 * created by twink @ 2013-5-12 下午4:18:59
	 * <p>
	 * 
	 */
	import com.twink.tools.data.DataCell;
	
	public class DataCellArr extends DataCell
	{
		/**
		 * 增加一个Data派发的事件
		 * <p>2个参数: (this:DataCellArr, data:*)
		 */		
		public static const ADD_DATA:String = "ADD_DATA";
		/**
		 * 删除一个Data派发的事件
		 * <p>2个参数: (this:DataCellArr, data:*)
		 */		
		public static const DEL_DATA:String = "DEL_DATA";
		
		//存储的信息字典
		private var _arr:Array = [];
		//存储数量上限 -1表示无限制
		private var _maxCount:int = -1;
		
		public function DataCellArr($maxCount:int = -1)
		{
			super(null);
			
			this.maxCount = $maxCount;
		}
		
		//======================================================
		//操作接口
		//======================================================
		
		/**
		 * 增加一条信息
		 * @param $data 内容
		 * 
		 */		
		public function addData($data:*):void
		{
			//交给外部判断 这里不该管这个
//			if ( this.hasData($data) )
//			{
//				//已经存在
//				return;
//			}
			
			if ( this.isFull )
			{
				//如果已经满了 就不能增加
				return;
			}
			
			_arr.push($data);
			
			this.alertAddData($data);
			this.update();
		}
		
		/**
		 * 通过索引ID删除一条信息
		 * @param $ID 要删除信息的索引ID
		 * 
		 */		
		public function delData($data:*):void
		{
			var index:int = _arr.indexOf($data);
			if ( index != -1 )
			{
				_arr.splice(index, 1);
				
				//清除掉一个
				this.alertDelData($data);
				
				if ( this.hasData($data) )
				{
					//存在重复出现的信息
					//清除干净
					this.delData($data);
				}
				else
				{
					//全部清除完毕
					this.update();
				}
			}
		}
		
		/**
		 * 清空
		 * 
		 */		
		public override function clear():void
		{
			super.clear();
			
			_arr = [];
			
			this.updateClear();
		}
		
		//======================================================
		//设置接口
		//======================================================
		
		/**
		 * 设置存储上限 -1表示无限制
		 * @param $value
		 * 
		 */		
		public function set maxCount($value:int):void
		{
			_maxCount = $value;
			this.update();
		}
		
		//======================================================
		//查询接口
		//======================================================
		
		/**
		 * 通过索引查询信息
		 * @param $index 索引
		 * @return 信息内容
		 * 
		 */		
		public function getDataByIndex($index:int):*
		{
			return _arr[$index];
		}
		
		/**
		 * 获得信息总数
		 * @return 
		 * 
		 */		
		public function get count():int
		{
			return _arr.length;
		}
		
		/**
		 * 获得存储上线 -1表示无限制
		 * @return 
		 * 
		 */		
		public function get maxCount():int
		{
			return _maxCount;
		}
		
		/**
		 * 查询是否已满
		 * @return 
		 * 
		 */		
		public function get isFull():Boolean
		{
			if ( this.maxCount == -1 )
			{
				//无限容量 所以必定未满
				return false;
			}
			return (this.count >= this.maxCount);
		}
		
		/**
		 * 查询是否存在这个信息
		 * @param $data 要查询的信息
		 * @return 是否存在
		 * 
		 */		
		public function hasData($data:*):Boolean
		{
			var index:int = _arr.indexOf($data);
			if ( index == -1 )
			{
				return false;
			}
			return true;
		}
		
		/**
		 * 获得原始数组
		 * @return 
		 * 
		 */		
		public function get arr():Array
		{
			return _arr;
		}
		
		//======================================================
		//内部接口
		//======================================================
		
		/**
		 * 通知外界信息增加
		 * @param $data 增加的信息内容
		 * 
		 */		
		protected function alertAddData($data:*):void
		{
			this.send(DataCellDic.ADD_DATA, this, $data);
		}
		
		/**
		 * 通知外界信息删除
		 * @param $data 被删除的信息内容
		 * 
		 */		
		protected function alertDelData($data:*):void
		{
			this.send(DataCellDic.DEL_DATA, this, $data);
		}
	}
}