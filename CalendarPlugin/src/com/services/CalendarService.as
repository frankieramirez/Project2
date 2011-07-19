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
		
		public function CalendarService()
		{
			super();
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
			for each(var entry:XML in xmlData.ATOM::entry)
			{
				var cvo:CalendarVO = new CalendarVO();
				cvo.author = entry.ATOM::author.ATOM::name;
				cvo.published = entry.ATOM::published;
				cvo.summary = entry.ATOM::summary;
				cvo.title = entry.ATOM::title;
				_calendarEvents.push(cvo);
			}
			
			var evt:CalendarServiceEvent = new CalendarServiceEvent(CalendarServiceEvent.CALEVENT_FOUND)
			evt.CalEvents = _calendarEvents;
			dispatchEvent(evt);
		}
		
		private function onLoadFail(e:IOErrorEvent):void
		{
			
		}
	}
}