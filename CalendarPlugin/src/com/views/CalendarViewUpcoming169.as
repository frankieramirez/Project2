package com.views
{
	import com.VO.CalendarVO;
	
	import libs.CalendarViewUpcomingBase16x9;
	
	public class CalendarViewUpcoming169 extends CalendarViewUpcomingBase16x9
	{
		private var _calEvent:CalendarVO;
		
		public function CalendarViewUpcoming169(calEvent:CalendarVO)
		{
			super();
			
			_calEvent = calEvent;
			
			tfUpcomingTime.text = _calEvent.time + _calEvent.ampm;
			tfUpcomingTitle.text = _calEvent.title;
		}
		
		public function set calEvent(value:CalendarVO):void
		{
			_calEvent = value;
		}
	}
}