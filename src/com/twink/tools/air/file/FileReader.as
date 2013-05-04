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
	 * 文件读取器
	 */
	public class FileReader extends Messager
	{
		//存储已下载的各种资源
		private var _storageDic:Dictionary = new Dictionary();
		
		public function FileReader()
		{
			super();
		}
		
		public function read($url:String):void
		{
			var file:File = new File($url);
			
			var stream:FileStream = new FileStream;
			stream.open(file, FileMode.READ);
			var bytes:ByteArray = new ByteArray;
			stream.readBytes(bytes, 0, stream.bytesAvailable);
			
			stream.close();
			
			var loader:Loader;
			loader = new Loader;
			loader.unload();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
			loader.loadBytes(bytes);
		}
		
		private function imageLoaded(event:Event):void
		{
			event.target.removeEventListener(Event.COMPLETE, imageLoaded);
			
//			var bitmap:Bitmap = Bitmap(event.target.loader.content);
//			result.addChild(bitmap);
		}
	}
}