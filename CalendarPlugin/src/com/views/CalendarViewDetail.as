package com.views
{
	import com.VO.CalendarVO;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import libs.CalendarViewDetailBase;
	
	public class CalendarViewDetail extends CalendarViewDetailBase
	{
		private var _calEvent:CalendarVO;
		private var _tf:TextField;
		
		public function CalendarViewDetail(calEvent:CalendarVO)
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