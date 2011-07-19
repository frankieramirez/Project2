package com.events
{
	import flash.events.Event;
	
	public class NewsServiceEvent extends Event
	{
		public static const NEWS_FOUND:String = "NewsFound";
		
		public var newsEvents:Array;
		
		public function NewsServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}