package com.views
{
	import com.VO.CalendarVO;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class CalendarViewDetail extends Sprite
	{
		private var _calEvent:CalendarVO;
		private var _tf:TextField;
		
		public function CalendarViewDetail(calEvent:CalendarVO)
		{
			super();
			
			_calEvent = calEvent;
			_tf = new TextField();
			addChild(_tf);
			_tf.text = _calEvent.title;
		}

		public function set calEvent(value:CalendarVO):void
		{
			_calEvent = value;
		}

	}
}