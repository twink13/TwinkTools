package com.twink.tools.load
{
	/**
	 * created by twink @ 2013-7-27 下午8:04:44
	 * <p>
	 * 单个文件的加载类
	 * 2013-07-28 完成本地文件加载
	 */
	import com.twink.tools.message.Messager;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	public class ReaderItem extends Messager
	{
		//加载完成
		public static const COMPLETE:String = "COMPLETE";
		//清除完毕
		public static const CLEARED:String = "CLEARED";
		
		//
		private var _readerData:ReaderData = null;
		
		//加载器
		private var _loader:Loader = new Loader();
		//加载流
		private var _stream:FileStream = new FileStream();
		//文件流
		private var _file:File = new File();
		
		public function ReaderItem()
		{
			super();
		}
		
		//=================================================================================
		//对外接口
		//=================================================================================
		
		/**
		 * 开始加载
		 * @param $url 目标完整url
		 * @param $positionType 目标位置(网络/本地)
		 * @param $fileType 文件类型
		 * 
		 */		
		public function read($readerData:ReaderData):void
		{
			if ( this.reading )
			{
				//正在加载
				return;
			}
			
			//可以加载
			_readerData = $readerData;
			
			switch (_readerData.sourceType)
			{
				case ReaderTypes.SOURCE_TYPE_LOCAL:
				{
					//本地文件
					this.startReadLocalFile();
					break;
				}
				case ReaderTypes.SOURCE_TYPE_NET:
				{
					//网络文件
					break;
				}
				default:
				{
					//没用这个类型啊
					throw(new Error("试图加载一个无法预知位置的文件! _readerData = " + _readerData))
					break;
				}
			}
		}
		
		/**
		 * 停止加载
		 * 
		 */		
		public function stopRead():void
		{
			this.stopReadLocalFile();
			
			//清空数据
			_readerData = null;
		}
		
		
//		public override function toString():String
//		{
//			return "[" + super.toString() + ": url = " + this.url + ", positionType = " + this.positionType + ", fileType" + this.fileType + "]";
//		}
		
		//=================================================================================
		//getters
		//=================================================================================
		
		/**
		 * 返回是否正在加载
		 * @return 
		 * 
		 */		
		public function get reading():Boolean
		{
			//如果有在加载的数据 表示正在加载 否则认为没有在加载
			return (_readerData != null);
		}
		
		/**
		 * 返回正在加载的加载数据
		 * @return 
		 * 
		 */		
		public function get readerData():ReaderData
		{
			return _readerData;
		}
		
		//=================================================================================
		//私有处理 - 一般
		//=================================================================================
		
		//完成操作
		private function complete():void
		{
			//先通知外界加载完成
			this.alertComplete();
			
			//清空加载器
			this.stopRead();
			
			//通知外界(加载器)清除完成
			this.alertCleared();
		}
		
		//发送完成事件
		private function alertComplete():void
		{
			this.send(ReaderItem.COMPLETE, this);
		}
		
		//发送清除完毕事件
		private function alertCleared():void
		{
			this.send(ReaderItem.CLEARED, this);
		}
		
		//=================================================================================
		//私有处理 - 本地文件
		//=================================================================================
		
		//开始加载本地文件
		private function startReadLocalFile():void
		{
			//_file.url = _readerData.url;
			_file = new File(_readerData.url);
			_stream.open(_file, FileMode.READ);
			
			switch (_readerData.fileType)
			{
				case ReaderTypes.FILE_TYPE_BMP:
				{
					//图像资源
					var bytes:ByteArray = new ByteArray;
					_stream.readBytes(bytes, 0, _stream.bytesAvailable);
					
					_loader.unload();
					_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, contentLoaded);
					_loader.loadBytes(bytes);
					
					break;
				}
				case ReaderTypes.FILE_TYPE_TXT:
				case ReaderTypes.FILE_TYPE_XML:
				case ReaderTypes.FILE_TYPE_TXT:
				{
					//文本资源
					_readerData.contentData.value = _stream.readUTFBytes(_stream.bytesAvailable);//String类型
					this.complete();
					
					break;
				}
				default:
				{
					//没用这个类型啊
					throw(new Error("试图加载没用文件类型的文件! _readerData = " + _readerData))
					break;
				}
			}
		}
		
		//停止加载本地文件
		private function stopReadLocalFile():void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, contentLoaded);
		}
		
		//加载完毕
		private function contentLoaded(event:Event):void
		{
			if ( _loader.content is Bitmap )
			{
				_readerData.contentData.value = (_loader.content as Bitmap).bitmapData;
			}
			else
			{
				_readerData.contentData.value = _loader.content;
			}
			
			//此时这个加载器已经可以再次实用 但之前先派发这个消息
			this.complete();
		}
	}
}