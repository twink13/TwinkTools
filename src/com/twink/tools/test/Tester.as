package com.twink.tools.test
{
	import com.twink.tools.message.Messager;

	/**
	 * created by twink @ 2013-9-1 下午2:12:32
	 * <p>
	 * 测试类
	 */
	public class Tester extends Messager
	{
		//测试结束 无参数
		public static const TEST_COMPLETE:String = "TEST_COMPLETE";
		
		private var _testFunList:Array = new Array();
		private var _testInfoList:Array = new Array();
		private var _index:int = -1;
		
		public function Tester()
		{
		}
		
		/**
		 * 测试某个函数
		 * @param $fun
		 * @param $info
		 * 
		 */		
		public function addTest($fun:Function, $info:String):void
		{
			_testFunList.push($fun);
			_testInfoList.push($info);
		}
		
		/**
		 * 开始测试
		 * 
		 */		
		public function startTest():void
		{
			this.next();
		}
		
		/**
		 * 测试下一个
		 * 
		 */		
		public function next():void
		{
			if ( !this.haveNext )
			{
				this.log("测试结束! ");
				this.send(Tester.TEST_COMPLETE);
				return;
			}
			
			_index++;
			
			var testFun:Function = _testFunList[_index];
			var testInfo:String = _testInfoList[_index];
			
			this.log("开始测试: " + testInfo);
			testFun();
		}
		
		/**
		 * 查询是否存在下一个
		 * @return 
		 * 
		 */		
		public function get haveNext():Boolean
		{
			if ( _index >= _testFunList.length - 1 )
			{
				return false;
			}
			return true;
		}
		
		private function log($info:String):void
		{
			trace($info);
		}
	}
}