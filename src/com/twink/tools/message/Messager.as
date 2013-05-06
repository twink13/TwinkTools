package com.twink.tools.message
{
	import flash.utils.Dictionary;

	/**
	 * created by twink @ 2013-5-1 下午7:16:16
	 * <p>
	 * 消息派发器
	 */
	public class Messager
	{
		//存储的所有事件
		private var _eventDic:Dictionary = new Dictionary();
		
		public function Messager()
		{
		}
		
		/**
		 * 派发一个消息
		 * @param $eventID 事件名
		 * @param args 消息参数 参数个数可变但要和侦听器相符
		 * 
		 */		
		public function send($eventID:String, ...args):void
		{
			var evnetData:EventData = _eventDic[$eventID];
			if ( !evnetData )
			{
				//不存在的事件名
				return;
			}
			
			evnetData.send.apply(this, args);
		}
		
		/**
		 * 添加一个侦听
		 * @param $eventID 事件名
		 * @param $listener 侦听函数引用
		 * 
		 */		
		public function addListener($eventID:String, $listener:Function):void
		{
			var evnetData:EventData = _eventDic[$eventID];
			if ( !evnetData )
			{
				//不存在的事件名 新创建一个
				evnetData = new EventData($eventID);
				_eventDic[$eventID] = evnetData;
			}
			
			evnetData.addListener($listener);
		}
		
		/**
		 * 移除一个侦听
		 * @param $eventID 事件名
		 * @param $listener 侦听函数引用
		 * 
		 */		
		public function removeListener($eventID:String, $listener:Function):void
		{
			var evnetData:EventData = _eventDic[$eventID];
			if ( !evnetData )
			{
				//不存在的事件名
				return;
			}
			
			evnetData.removeListener($listener);
		}
		
		/**
		 * 查询是否存在侦听
		 * @param $eventID 事件名
		 * @param $listener 目标侦听器
		 * @return 是否存在
		 * 
		 */		
		public function haveListener($eventID:String, $listener:Function):Boolean
		{
			var evnetData:EventData = _eventDic[$eventID];
			if ( !evnetData )
			{
				//不存在这个侦听器
				return false;
			}
			
			return evnetData.haveListener($listener);
		}
		
		//===================================================================
		//其他接口
		//===================================================================
		
		/**
		 * 清空
		 * 
		 */		
		public function clear():void
		{
			_eventDic = new Dictionary();
		}
	}
}