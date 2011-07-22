package com.views
{
	import com.VO.CalendarVO;
	
	import libs.CalendarViewUpcomingTitleBase;
	
	public class CalendarViewUpcomingTitle extends CalendarViewUpcomingTitleBase
	{
		private var _title:CalendarVO;
		
		public function CalendarViewUpcomingTitle()
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