package com.twink.tools.UI
{
	/**
	 * created by twink @ 2013-5-11 下午7:39:14
	 * <p>
	 * UI基类
	 */
	import com.twink.tools.component.Component;
	import com.twink.tools.data.DataCell;
	import com.twink.tools.message.Messager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class UI extends Component
	{
		public static const STATE_CLOSE:String 			= "STATE_CLOSE";		//关闭
		public static const STATE_SHOWING:String 		= "STATE_SHOWING";		//正在显示
		
		//当前状态
		private var _stateData:DataCell = new DataCell(UI.STATE_CLOSE);
		
		public function UI()
		{
			super();
		}
		
		//===================================================================
		//外部接口
		//===================================================================
		
		/**
		 * 打开UI
		 * 
		 */		
		public function open():void
		{
			if ( this.opened )
			{
				//已经在显示
				return;
			}
		}
		
		/**
		 * 关闭UI
		 * 
		 */		
		public function close():void
		{
			if ( this.display && this.display.parent )
			{
				this.display.parent.removeChild(this.display);
			}
		}
		
		/**
		 * 查询是否已经开启
		 * @return 
		 * 
		 */		
		public function get opened():Boolean
		{
			return this.currentState != UI.STATE_CLOSE;
		}
		
		/**
		 * 获得当前状态
		 * @return 
		 * 
		 */		
		public function get currentState():String
		{
			return _stateData.value;
		}
		
		//===================================================================
		//对内接口
		//===================================================================
		
		
		//===================================================================
		//纯私有
		//===================================================================
	}
}