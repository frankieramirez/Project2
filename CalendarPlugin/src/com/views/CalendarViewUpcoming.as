package com.views
{
	import com.VO.CalendarVO;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import libs.CalendarViewUpcomingBase;
	
	public class CalendarViewUpcoming extends CalendarViewUpcomingBase
	{
		private var _calEvent:CalendarVO;
		private var _tf:TextField;
		
		//TODO display some of the information, not as much as detailed
		public function CalendarViewUpcoming(calEvent:CalendarVO)
		{
			super();
			
			_calEvent = calEvent;
			
			tfUpcomingTime.text = "??:??";
			tfUpcomingTitle.text = _calEvent.title;
			//_tf = new TextField();
			//addChild(_tf);
			//_tf.text = _calEvent.title;
		}

		public function set calEvent(value:CalendarVO):void
		{
			_calEvent = value;
		}

	}
}