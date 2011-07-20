package com.views
{
	import flash.display.Sprite;
	
	public class CalendarView extends Sprite
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
				cvd.y += 30*i;
				addChild(cvd);
				_displayedItems.push(cvd);
			}
			
			for(var j:int = 3; j < _calEvents.length; j++)
			{
				var cvu:CalendarViewUpcoming = new CalendarViewUpcoming(_calEvents[j]);
				cvu.x = 150;
				cvu.y = (20*j) - 60;
				addChild(cvu);
				_displayedItems.push(cvd);
			}
			
		}

	}
}