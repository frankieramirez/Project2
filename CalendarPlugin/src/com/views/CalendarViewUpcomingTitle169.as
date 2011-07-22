package com.views
{
	import com.VO.CalendarVO;
	
	import libs.CalendarViewUpcomingTitleBase16x9;
	
	public class CalendarViewUpcomingTitle169 extends CalendarViewUpcomingTitleBase16x9
	{
		private var _title:CalendarVO;
		
		public function CalendarViewUpcomingTitle169()
		{
			super();
		}
		
		private function updateText():void
		{
			tfTitle.text = _title.dayName + ", " + _title.monthName + " " + _title.day + ", " + _title.year;
		}
		
		public function set title(title:CalendarVO):void
		{
			_title = title;
			updateText();
		}
	}
}