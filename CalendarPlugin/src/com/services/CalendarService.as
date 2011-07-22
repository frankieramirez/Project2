package com.services
{
	import com.VO.CalendarVO;
	import com.events.CalendarServiceEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class CalendarService extends EventDispatcher
	{
		private var _calendarEvents:Array = [];
		private var _monthName:String;
		private var _dayArrayNames:Array;
		
		public function CalendarService()
		{
			super();
			
			_dayArrayNames= ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		}
		
		public function load(url:String):void
		{
			var ul:URLLoader = new URLLoader();
			ul.load(new URLRequest(url));
			ul.addEventListener(Event.COMPLETE, onLoadComplete);
			ul.addEventListener(IOErrorEvent.IO_ERROR, onLoadFail);
		}
		
		private function onLoadComplete(e:Event):void
		{
			var xmlData:XML = XML(e.currentTarget.data);
			
			var ATOM:Namespace = new Namespace('http://www.w3.org/2005/Atom');
			var GD:Namespace = new Namespace('http://schemas.google.com/g/2005');
			for each(var entry:XML in xmlData.ATOM::entry)
			{
				var cvo:CalendarVO = new CalendarVO();
				cvo.summary = entry.ATOM::summary;
				cvo.title = entry.ATOM::title;
				cvo.content = entry.ATOM::content;
				cvo.whenEnd = entry.GD::when.@endTime;
				cvo.whenStart = entry.GD::when.@startTime;
				
				//splits the day and time up, god help us all
				var dateArray:Array = cvo.whenStart.split("T");
				var timeSt:String = dateArray[1];
				var timeArray:Array = timeSt.split(".");
				timeSt = timeArray[0].toString();
				cvo.time = timeSt;
				cvo.date = dateArray[0];
				var dt:String = dateArray[0];
				dateArray = dt.split("-");
				cvo.year = dateArray[0];
				cvo.month = dateArray[1];
				cvo.day = dateArray[2];
				
				calendarSwitch(cvo.month);
				cvo.monthName = _monthName;
				
				var dt2:Date = new Date(cvo.year, (cvo.month-1), cvo.day);
				cvo.dayName = _dayArrayNames[dt2.day];
				
				_calendarEvents.push(cvo);
			}
			
			var evt:CalendarServiceEvent = new CalendarServiceEvent(CalendarServiceEvent.CALEVENT_FOUND)
			evt.CalEvents = _calendarEvents;
			dispatchEvent(evt);
		}
		
		private function onLoadFail(e:IOErrorEvent):void
		{
			
		}
		
		private function calendarSwitch(month:int):void
		{
			switch(month)
			{
				case 1:
					_monthName = 'January';
					break;
				case 2:
					_monthName = 'February';
					break;
				case 3:
					_monthName = 'March';
					break;
				case 4:
					_monthName = 'April';
					break;
				case 5:
					_monthName = 'May';
					break;
				case 6:
					_monthName = 'June';
					break;
				case 7:
					_monthName = 'July';
					break;
				case 8:
					_monthName = 'August';
					break;
				case 9:
					_monthName = 'September';
					break;
				case 10:
					_monthName = 'October';
					break;
				case 11:
					_monthName = 'November';
					break;
				case 12:
					_monthName = 'December';
					break;
			}
		}
	}
}