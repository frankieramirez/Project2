package com.zambi.event
{
	import com.zambi.vo.InfoVO;
	
	import flash.events.Event;
	
	public class WeatherServiceEvent extends Event
	{
		public static const DATA_LOADED:String = "dataLoaded";
		public static const LOAD_FAILED:String = "loadFailed";
		
		public var data:InfoVO;
		
		public function WeatherServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}