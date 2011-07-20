package com.views
{
	import com.VO.CalendarVO;
	
	import flash.display.Sprite;
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
			tfEventTitle.text = _calEvent.title;
			tfEventPlace.text = _calEvent.summary;
			tfEventTime.text = "????";
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