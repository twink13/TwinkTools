package com.twink.tools.UI
{
	/**
	 * created by twink @ 2013-5-11 下午7:39:14
	 * <p>
	 * UI基类
	 */
	import com.twink.tools.data.DataCell;
	import com.twink.tools.message.Messager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class UI extends Messager
	{
		public static const STATE_CLOSE:String 			= "STATE_CLOSE";		//关闭
		public static const STATE_SHOWING:String 		= "STATE_SHOWING";		//正在显示
		
		//UI对应显示对象的存储容器
		private var _displayData:DataCell = new DataCell(null);
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
		public function open($display:DisplayObject):void
		{
			if ( this.opened )
			{
				//已经在显示
				return;
			}
			
			_displayData.value = $display;
			
			this.display.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			this.addUIToStage();
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
		 * 获得关联的资源
		 * @return 
		 * 
		 */		
		public function get display():DisplayObject
		{
			return _displayData.value as DisplayObject;
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
		
		/**
		 * 添加UI到舞台 具体做法由继承者决定
		 * 
		 */		
		protected function onAddToStage($evt:Event):void
		{
			//改变状态
			_stateData.value = UI.STATE_SHOWING;
			
			this.display.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		/**
		 * 从舞台移除
		 * @param $evt
		 * 
		 */		
		protected function onRemoveFromStage($evt:Event):void
		{
			//清空事件侦听
			this.display.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			this.display.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			_displayData.removeListener(DataCell.UPDATE, onGetDisplay);
			
			_displayData.value = null;
			
			//改变状态
			_stateData.value = UI.STATE_CLOSE;
		}
		
		/**
		 * 将UI资源加入到显示列表中
		 * 
		 */		
		protected function addUIToStage():void
		{
			throw(new Error("请重写addUIToStage方法! this = " + this));
		}
		
		//===================================================================
		//纯私有
		//===================================================================
		
		//获得显示用资源
		private function onGetDisplay($data:DataCell):void
		{
			if ( this.display )
			{
				_displayData.removeListener(DataCell.UPDATE, onGetDisplay);
				
				this.display.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
				this.addUIToStage();
			}
		}
	}
}