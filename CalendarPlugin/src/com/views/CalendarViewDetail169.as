package com.views
{
	import com.VO.CalendarVO;
	
	import libs.CalendarViewDetailBase16x9;
	
	public class CalendarViewDetail169 extends CalendarViewDetailBase16x9
	{
		private var _calEvent:CalendarVO;
		
		public function CalendarViewDetail169(calEvent:CalendarVO)
		{
			super();
			_calEvent = calEvent;
			
			updateText();
		}
		
		private function updateText():void
		{
			if(_calEvent)
			{
				tfEventTitle.text = _calEvent.title;
				tfDay.text = String(_calEvent.day);
				tfMonth.text = _calEvent.monthName;
				tfEventTime.text = _calEvent.time;
				tfEventPlace.text = _calEvent.content;
				tfEventProgress.text = "";
			}else{
				this.alpha = 0;
				tfEventTitle.text = "";
				tfDay.text = "";
				tfMonth.text = "";
				tfEventTime.text = "";
				tfEventPlace.text = "";
				tfEventProgress.text = "";
			}
			
		}
		
		public function set calEvent(value:CalendarVO):void
		{
			_calEvent = value;
			updateText();
		}
	}
}