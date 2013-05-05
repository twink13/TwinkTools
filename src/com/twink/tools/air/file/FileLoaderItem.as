package com.twink.tools.air.file
{
	import com.twink.tools.message.Messager;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	/**
	 * 维护人：twink 2013-5-4 - 今
	 * <p>
	 * 单个文件加载器 内联
	 */
	internal class FileLoaderItem extends Messager
	{
		public static const COMPLETE:String = "COMPLETE";
		
		//正在加载的url
		private var _url:String = null;
		//指定是否存储
		private var _save:Boolean = false;
//		//已读取完毕的文件内容 发现这个没用...
//		private var _content:* = null;
		//锁状态 默认false
		private var _locked:Boolean = false;
		
		//加载器
		private var _loader:Loader = new Loader();
		//加载流
		private var _stream:FileStream = new FileStream();
		
		public function FileLoaderItem()
		{
		}
		
		//===================================================
		//操作接口
		//===================================================
		
		/**
		 * 加载一个url
		 * @param $url
		 * 
		 */		
		public function read($url:String, $save:Boolean):void
		{
			this.stopRead();
			
			_locked = true;//状态改为锁定
			
			var file:File = new File($url);
			
			_stream.open(file, FileMode.READ);
			var bytes:ByteArray = new ByteArray;
			_stream.readBytes(bytes, 0, _stream.bytesAvailable);
			
			_stream.close();
			
			_loader.unload();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, contentLoaded);
			_loader.loadBytes(bytes);
		}
		
		/**
		 * 停止加载
		 * 
		 */		
		public function stopRead():void
		{
			_loader.removeEventListener(Event.COMPLETE, contentLoaded);
			_loader.close();
			
			_url = null;
			//_content = null;//改为下次加载完毕时覆盖
			_locked = false;//状态改为非锁定
		}
		
		//===================================================
		//getter接口
		//===================================================
		
		/**
		 * 获取当前加载的url
		 * @return 
		 * 
		 */		
		public function get url():String
		{
			return _url;
		}
		
//		/**
//		 * 获取加载完毕的信息内容
//		 * @return 
//		 * 
//		 */		
//		public function get content():Object
//		{
//			return _content;
//		}
		
		//===================================================================
		//锁定相关操作
		//===================================================================
		
		/**
		 * 查询是否锁定了
		 * @return 锁定状态
		 * 
		 */		
		public function get locked():Boolean
		{
			return _locked;
		}
		
		//===================================================
		//私有
		//===================================================
		
		//加载完毕
		private function contentLoaded(event:Event):void
		{
			//关闭这个加载器
			this.stopRead();
			
			//此时这个加载器已经可以再次实用 但之前先派发这个消息
			this.send(FileLoaderItem.COMPLETE, _url, _loader.content, _save);
		}
	}
}