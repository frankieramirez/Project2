package com.events
{
	import flash.events.Event;
	
	public class CalendarServiceEvent extends Event
	{
		//TODO add array to this event
		
		public function CalendarServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}