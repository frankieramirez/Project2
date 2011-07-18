package com.ramirez.events
{
	import flash.events.Event;
	
	public class TwitServiceEvent extends Event
	{
		public static const DATA_LOADED:String = "dataLoaded";
		public static const LOAD_FAILED:String = "loadFailed";
		
		public var data:Array;
		
		public function TwitServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new TwitServiceEvent(type,bubbles,cancelable);
		}
	}
}