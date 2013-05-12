package com.twink.tools.dataContainer
{
	import com.twink.tools.data.DataCell;
	
	import flash.utils.Dictionary;

	/**
	 * created by twink @ 2013-5-12 下午3:48:36
	 * <p>
	 * 字典类信息存储器
	 */
	public class DataCellDic extends DataCell
	{
		/**
		 * 增加一个Data派发的事件
		 * <p>3个参数: (this:DataCellDic, ID:String, data:*)
		 */		
		public static const ADD_DATA:String = "ADD_DATA";
		/**
		 * 删除一个Data派发的事件
		 * <p>3个参数: (this:DataCellDic, ID:String, data:*)
		 */		
		public static const DEL_DATA:String = "DEL_DATA";
		
		//存储的信息字典
		private var _dic:Dictionary = new Dictionary();
		//当前存储数量
		private var _count:int = 0;
		//存储数量上限 -1表示无限制
		private var _maxCount:int = -1;
		
		//ID列表
		private var _IDArrData:DataCellArr = new DataCellArr();
		//data列表
		private var _dataArrData:DataCellArr = new DataCellArr();
		
		public function DataCellDic($maxCount:int = -1)
		{
			super(null);
			
			this.maxCount = $maxCount;
		}
		
		//======================================================
		//操作接口
		//======================================================
		
		/**
		 * 增加一条信息
		 * @param $ID 索引ID
		 * @param $data 内容
		 * 
		 */		
		public function addData($ID:String, $data:*):void
		{
			//先删除
			this.delDataByID($ID);
			
			if ( this.isFull )
			{
				//如果已经满了 就不能增加
				return;
			}
			
			_dic[$ID] = $data;
			_count++;
			
			_IDArrData.addData($ID);
			_dataArrData.addData($data);
			
			this.alertAddData($ID, $data);
			this.update();
		}
		
		/**
		 * 通过索引ID删除一条信息
		 * @param $ID 要删除信息的索引ID
		 * 
		 */		
		public function delDataByID($ID:String):void
		{
			var data:* = _dic[$ID];
			if ( data )
			{
				_dic[$ID] = null;
				delete _dic[$ID];
				_count--;
				
				_IDArrData.delData($ID);
				_dataArrData.delData(data);
				
				this.alertDelData($ID, data);
				this.update();
			}
		}
		
		/**
		 * 清空
		 * 
		 */		
		public override function clear():void
		{
			super.clear();
			
			_dic = new Dictionary();
			_count = 0;
			_IDArrData.clear();
			_dataArrData.clear();
			
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
		 * 通过索引ID查询信息
		 * @param $ID 索引ID
		 * @return 信息内容
		 * 
		 */		
		public function getDataByID($ID:String):*
		{
			return _dic[$ID];
		}
		
		/**
		 * 获得信息总数
		 * @return 
		 * 
		 */		
		public function get count():int
		{
			return _count;
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
			return (this.count >= this.maxCount);
		}
		
		/**
		 * 获得ID列表信息
		 * @return 
		 * 
		 */		
		public function get IDArrData():DataCellArr
		{
			return _IDArrData;
		}
		
		/**
		 * 获得信息列表信息
		 * @return 
		 * 
		 */		
		public function get dataArrData():DataCellArr
		{
			return _dataArrData;
		}
		
		//======================================================
		//内部接口
		//======================================================
		
		/**
		 * 通知外界信息增加
		 * @param $ID 增加信息的索引ID
		 * @param $data 增加的信息内容
		 * 
		 */		
		protected function alertAddData($ID:String, $data:*):void
		{
			this.send(DataCellDic.ADD_DATA, this, $ID, $data);
		}
		
		/**
		 * 通知外界信息删除
		 * @param $ID 被删除信息的索引ID
		 * @param $data 被删除的信息内容
		 * 
		 */		
		protected function alertDelData($ID:String, $data:*):void
		{
			this.send(DataCellDic.DEL_DATA, this, $ID, $data);
		}
	}
}