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
		//存储已下载的各种资源 key:url value:加载到的内容
		private var _storageDic:Dictionary = new Dictionary();
		//加载器列表
		private var _loaders:Array = [];
		//等待列表
		private var _waitList:Array = [];
		
		public function FileReader()
		{
			super();
			
			for ( var i:int = 0; i < 3; i++ )
			{
				var loader:FileLoaderItem = new FileLoaderItem();
				loader.addListener(FileLoaderItem.COMPLETE, onLoadComplete);
			}
		}
		
		/**
		 * 加载一个文件
		 * @param $url 文件完整url
		 * @param $save 是否本地保存
		 * 
		 */		
		public function read($url:String, $save:Boolean = false):void
		{
			var content:* = _storageDic[$url];
			if ( content )
			{
				//已经保存过了
				this.send($url, $url, content);
			}
			
			//没找到 加到等待区
			_waitList.push([$url, $save]);
			this.check();
		}
		
		//检查是否有能下载的 如果有则开始加载并返回true 否则返回false
		private function check():Boolean
		{
			var loadReequest:Array = _waitList.shift();
			if ( loadReequest )
			{
				//存在要加载的内容
				var loader:FileLoaderItem = this.findLoader();
				if ( loader )
				{
					//找到了 开始加载
					loader.read.apply(this, loadReequest);
					return true;
				}
			}
			return false;
		}
		
		//寻找一个能用的加载器 如果没有就返回null
		private function findLoader():FileLoaderItem
		{
			var size:int = _loaders.length;
			for ( var i:int = 0; i < size; i++ )
			{
				var loader:FileLoaderItem = _loaders[i];
				if ( !loader.locked )
				{
					return loader;
				}
			}
			return null;
		}
		
		private function onLoadComplete($url:String, $content:*, $save:Boolean):void
		{
			if ( $save )
			{
				//要存
				_storageDic[$url] = $content;
			}
			this.send($url, $url, $content);
		}
	}
}