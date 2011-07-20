package com.views
{
	import flash.display.Sprite;
	
	import libs.CalendarViewBase;
	
	public class CalendarView extends CalendarViewBase
	{
		private var _calEvents:Array = [];
		private var _displayedItems:Array = [];
		
		public function CalendarView()
		{
			super();
		}

		public function set calEvents(value:Array):void
		{
			_calEvents = value;
			
			for(var i:int; i < 3; i++)
			{
				var cvd:CalendarViewDetail = new CalendarViewDetail(_calEvents[i]);
				cvd.y += (cvd.height*i) + 100;
				addChild(cvd);
				_displayedItems.push(cvd);
			}
			
			for(var j:int = 3; j < _calEvents.length; j++)
			{
				var cvu:CalendarViewUpcoming = new CalendarViewUpcoming(_calEvents[j]);
				cvu.x = cvd.width + 20;
				cvu.y = (cvu.height*j);
				addChild(cvu);
				_displayedItems.push(cvd);
			}
			
		}

	}
}