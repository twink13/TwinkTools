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
		//已读取完毕的文件内容
		private var _content:Object = null;
		
		//
		private var _loade:Loader = new Loader();
		//
		private var _stream:FileStream = new FileStream();
		
		public function FileLoaderItem()
		{
		}
		
		//===================================================
		//操作接口
		//===================================================
		
		public function read($url:String):void
		{
			this.stopRead();
			
			var file:File = new File($url);
			
			_stream.open(file, FileMode.READ);
			var bytes:ByteArray = new ByteArray;
			_stream.readBytes(bytes, 0, _stream.bytesAvailable);
			
			_stream.close();
			
			_loade.unload();
			_loade.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
			_loade.loadBytes(bytes);
		}
		
		public function stopRead():void
		{
			_loade.removeEventListener(Event.COMPLETE, imageLoaded);
			_loade.close();
			
			_url = null;
			_content = null;
		}
		
		//===================================================
		//getter接口
		//===================================================
		
		public function get url():String
		{
			return _url;
		}
		
		public function get content():Object
		{
			return _content;
		}
		
		//===================================================
		//私有
		//===================================================
		
		private function imageLoaded(event:Event):void
		{
			_loade.removeEventListener(Event.COMPLETE, imageLoaded);
			
			this.send(FileLoaderItem.COMPLETE, _loade.content);
		}
	}
}