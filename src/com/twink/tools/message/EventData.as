package com.twink.tools.message
{
	/**
	 * created by twink @ 2013-5-1 下午7:17:52
	 * <p>
	 * 事件数据 内联类
	 */
	internal class EventData
	{
		//事件ID
		private var _ID:String;
		//事件回调函数列表 元素=Function 默认为空
		private var _listeners:Array = [];
		//锁状态 true表示当前事件正在触发中 默认false
		private var _locked:Boolean = false;
		//在锁住时 发生的函数调用 元素=[函数引用, 参数数组] 默认为空
		private var _lockedApplays:Array = [];
		
		public function EventData($ID:String)
		{
			_ID = $ID;
		}
		
		/**
		 * 发送这个事件
		 * @param ...args 参数列表 可选数量 但要和侦听器相符
		 * 该事件会逐一请求已添加的全部侦听
		 * <p>即使在发送的过程中移除已存在的某个侦听, 该侦听依然会被执行到, 当顺序执行完全部侦听之后再进行移除操作
		 */		
		public function send(...args):void
		{
			//开始执行前 先锁定
			_locked = true;
			
			var size:int = _listeners.length;
			for ( var i:int = 0; i < size; i++ )
			{
				var listener:Function = _listeners[i];
				listener.apply(this, args);
			}
			
			//执行完毕 取消锁定
			_locked = false;
			
			//执行临时添加的删除操作
			size = _lockedApplays.length;
			for ( i = 0; i < size; i++ )
			{
				//临时操作数组[函数引用, 参数数组]
				var tempOperationArr:Array = _lockedApplays[i];
				tempOperationArr[0].apply(this, tempOperationArr[1]);//执行
			}
			_lockedApplays = [];
		}
		
		/**
		 * 添加一个事件侦听
		 * @param $listener 新增的侦听器
		 * 要求不能是null 且 不能已存在
		 */		
		public function addListener($listener:Function):void
		{
			if ( $listener == null )
			{
				//不存在的侦听器 要不要报警
				return;
			}
			if ( this.haveListener($listener) )
			{
				//已经有了 搞毛啊
				return;
			}
			
			//合法
			_listeners.push($listener);//加到已侦听数组
		}
		
		/**
		 * 移除一个事件侦听
		 * @param $listener 新增的侦听器
		 * 要求不能是null 且 不能已存在
		 */		
		public function removeListener($listener:Function):void
		{
			if ( $listener == null )
			{
				//不存在的侦听器 要不要报警
				return;
			}
			var index:int = _listeners.indexOf($listener);
			if ( index == -1 )
			{
				//压根没有 搞毛啊
				return;
			}
			
			//合法
			if ( this.locked )
			{
				//在锁定状态 即使合法 也禁止继续 但会先记录操作
				_lockedApplays.push([this.removeListener, [$listener]]);//记录到临时操作列表中
				return;
			}
			
			_listeners.splice(index, 1);//从已侦听数组中移除
		}
		
		/**
		 * 查询是否存在某个侦听
		 * @param $listener 侦听器函数引用
		 * @return 是否存在
		 * 
		 */		
		public function haveListener($listener:Function):Boolean
		{
			var index:int = _listeners.indexOf($listener);
			if ( index != -1 )
			{
				return true;
			}
			return false;
		}
		
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
		
		//===================================================================
		//其他接口
		//===================================================================
		
		/**
		 * 清空
		 * 
		 */		
		public function clear():void
		{
			_listeners = [];
		}
	}
}