package com.twink.tools.load
{
	import com.twink.tools.dataContainer.DataCellDic;
	import com.twink.tools.library.ILibrary;
	import com.twink.tools.message.Messager;

	/**
	 * created by twink @ 2013-7-28 下午3:00:07
	 * <p>
	 * 资源加载类器
	 */
	public class Reader extends Messager
	{
		//单个文件加载完成
		public static const FILE_COMPLETE:String = "FILE_COMPLETE";
		//全部加载完成
		public static const ALL_COMPLETE:String = "ALL_COMPLETE";
		
		//下载完毕的资源存储器
		private var _lib:ILibrary = null;
		
		//单个文件加载器列表
		private var _readerItemList:Vector.<ReaderItem> = new Vector.<ReaderItem>();
		//等待下载的列表
		private var _waitList:DataCellDic = new DataCellDic();
		
		//同时下载数量上限 不能小于1
		private var _maxCount:int = 1;
		
		public function Reader($maxCount:int = 3)
		{
			super();
			
			_maxCount = $maxCount;
		}
		
		//=================================================================================
		//对外接口
		//=================================================================================
		
		/**
		 * 设定一个存储器
		 * @param $library 下载内容的存储器
		 * 
		 */		
		public function setLibrary($library:ILibrary):void
		{
			_lib = $library;
		}
		
		/**
		 * 开始加载
		 * @param $url 完整路径
		 * @param $sourceType 来源类型
		 * @param $fileType 文件类型
		 * @param $saveToLibrary 是否存储到库中 默认存储
		 * @param $priority 优先级 默认最低优先级
		 * 
		 */		
		public function read($url:String, $sourceType:String, $fileType:String, $saveToLibrary:Boolean = true, $priority:int = 0):void
		{
			//先校验能否read
			var readerData:ReaderData;
			if ( _lib )
			{
				readerData = _lib.getDataByID($url);
				if ( readerData )
				{
					//已经存在
					this.alertComplete(readerData);
					return;
				}
			}
			
			if ( _waitList.hasID($url) )
			{
				//已经在等待列表
				return;
			}
			
			//校验通过 需要加载
			readerData = new ReaderData();
			readerData.url 				= $url;
			readerData.sourceType 		= $sourceType;
			readerData.fileType			= $fileType;
			readerData.saveToLibrary 	= $saveToLibrary;
			readerData.priority 		= $priority;
			
			//添加到等待列表
			_waitList.addData(readerData.url, readerData);
			
			this.loadNext();
		}
		
		//=================================================================================
		//私有
		//=================================================================================
		
		//通知外界加载完毕
		private function alertComplete($readerData:ReaderData):void
		{
			this.send(Reader.FILE_COMPLETE, $readerData);
			
			//额外以url形式通知外界
			this.send($readerData.url, $readerData);
		}
		
		//寻找一个可用的读取器
		private function findReaderItem():ReaderItem
		{
			for ( var i:int = 0; i < _maxCount; i++ )
			{
				var readerItem:ReaderItem;
				
				if ( _readerItemList.length > i )
				{
					//只有在长度足够时 才能取到值 否则报错
					readerItem = _readerItemList[i];
				}
				else
				{
					//没有? 新创建一个
					readerItem = new ReaderItem();
					readerItem.addListener(ReaderItem.COMPLETE, onItemComplete);
					readerItem.addListener(ReaderItem.CLEARED, onItemCleared);
					
					_readerItemList.push(readerItem);
					return readerItem;
				}
				
				if ( !readerItem.reading )
				{
					//当前闲
					return readerItem;
				}
			}
			//全部忙
			return null;
		}
		
		//尝试读取下一个文件
		private function loadNext():void
		{
			if ( _waitList.isEmpty )
			{
				//等待列表为空 通知全部完毕
				this.send(Reader.ALL_COMPLETE);
				return;
			}
			
			var readerData:ReaderData = _waitList.dataArrData.arr[0];//第一个元素
			
			var readerItem:ReaderItem = this.findReaderItem();
			if ( !readerItem )
			{
				//现在忙 先等待加载完
				return;
			}
			
			//可以下载
			//从等待列表中删除
			_waitList.delDataByID(readerData.url);
			//开始下载
			readerItem.read(readerData);
		}
		
		//加载完成
		private function onItemComplete($readerItem:ReaderItem):void
		{
			if ( $readerItem.readerData.saveToLibrary )
			{
				//存储到库中
				_lib.add($readerItem.readerData.url, $readerItem.readerData);
			}
			
			this.alertComplete($readerItem.readerData);
		}
		
		//清除完毕
		private function onItemCleared($readerItem:ReaderItem):void
		{
			this.loadNext();
		}
	}
}