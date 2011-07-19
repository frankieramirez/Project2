package com.services
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class CalendarService extends EventDispatcher
	{
		public function CalendarService()
		{
			super();
			
			//TODO load XML through the url given
			//TODO parse the XML and create vo's stored into an array
			//TODO make an onload function and dispatch a custom event with an array
		}
	}
}