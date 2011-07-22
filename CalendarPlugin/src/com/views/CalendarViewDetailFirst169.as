package com.views
{
	import com.VO.CalendarVO;
	
	import flash.text.TextField;
	
	import libs.CalendarViewDetailBaseFirst16x9;
	
	public class CalendarViewDetailFirst169 extends CalendarViewDetailBaseFirst16x9
	{
		private var _calEvent:CalendarVO;
		private var _tf:TextField;
		
		public function CalendarViewDetailFirst169(calEvent:CalendarVO)
		{
		
			super();
			
			_calEvent = calEvent;
			
			updateText();
		}
		
		private function updateText():void
		{
			tfEventTitle.text = _calEvent.title;
			tfDay.text = String(_calEvent.day);
			tfMonth.text = _calEvent.monthName;
			tfEventTime.text = _calEvent.time;
			tfEventPlace.text = _calEvent.content;
			tfEventProgress.text = "";
		}
		
		public function set calEvent(value:CalendarVO):void
		{
			_calEvent = value;
			updateText();
		}
		}
}