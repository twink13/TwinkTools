package com.twink.tools
{
	/**
	 * created by twink @ 2013-5-11 下午7:39:14
	 * <p>
	 * UI基类
	 */
	import com.twink.tools.message.Messager;
	
	import flash.display.DisplayObject;
	
	public class UI extends Messager
	{
		//关联的资源
		private var _display:DisplayObject = null;
		
		public function UI()
		{
			super();
		}
		
		/**
		 * 打开UI
		 * @param $switchOpen 为true时,若已打开则关闭,若未打开则打开
		 * 
		 */		
		public function open($display:DisplayObject, $switchOpen:Boolean = false):void
		{
			if ( $switchOpen && this.opened )
			{
				this.close();
				return;
			}
			
			if ( this.opened )
			{
				return;
			}
			
			_display = $display;
			
			
		}
		
		/**
		 * 关闭UI
		 * 
		 */		
		public function close():void
		{
			if ( _display && _display.parent )
			{
				_display.parent.removeChild(_display);
			}
			_display = null;
		}
		
		/**
		 * 查询是否已经开启
		 * @return 
		 * 
		 */		
		public function get opened():Boolean
		{
			return this.display != null;
		}
		
		/**
		 * 获得关联的资源
		 * @return 
		 * 
		 */		
		public function get display():DisplayObject
		{
			return _display;
		}
		
		/**
		 * 添加UI到舞台 具体做法由继承者决定
		 * 
		 */		
		protected function addToStage():void
		{
		}
	}
}