package com.events
{
	import flash.events.Event;
	
	public class CalendarServiceEvent extends Event
	{
		public static const CALEVENT_FOUND:String = "CalEventFound";
		
		public var CalEvents:Array;
		
		public function CalendarServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}