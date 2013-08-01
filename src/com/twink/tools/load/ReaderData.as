package com.twink.tools.load
{
	import com.twink.tools.data.DataCell;
	import com.twink.tools.data.DataCellPercentage;

	/**
	 * created by twink @ 2013-7-28 下午3:18:44
	 * <p>
	 * 加载文件的数据 和状态信息
	 */
	public class ReaderData
	{
		//=================================================================================
		//不会变的
		//=================================================================================
		
		//目标url
		public var url:String = null;
		//来源类型
		public var sourceType:String = null;
		//文件类型
		public var fileType:String = null;
		//是否需要存储到库中
		public var saveToLibrary:Boolean = false;
		//优先级
		public var priority:int = 0;
		
		//=================================================================================
		//会变的
		//=================================================================================
		
		//是否正在加载
		public var isCompleteData:DataCell = new DataCell(false);
		//进度信息
		public var loadingPersentData:DataCellPercentage = new DataCellPercentage(0, 1);//初始值是为了默认百分比0
		//结果文件
		public var contentData:DataCell = new DataCell(null);
		
		public function ReaderData()
		{
		}
	}
}