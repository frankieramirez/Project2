package com.zambi.service
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	public class WeatherService extends EventDispatcher
	{
		private static const API_KEY:String = "A5477512792";
		private var _infoVOs:Array = [];
		
		public function WeatherService(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function search(zip:String = "32792"):void
		{
			var uVars:URLVariables = new URLVariables();
			uVars.apicode = API_KEY;
			uVars.SearchString = zip;
			
			var uReq:URLRequest = new URLRequest();
			uReq.data = uVars;
			uReq.url = "http://" +  API_KEY + ".api.wxbug.net/getLocationsXML.aspx";
			
			var uLoader:URLLoader = new URLLoader();
			uLoader.addEventListener(Event.COMPLETE, onSearchComplete);
			uLoader.load(uReq);
			
		}
		
		private function onSearchComplete(e:Event):void
		{
			trace(e.currentTarget);
			var uLoader:URLLoader = e.currentTarget as URLLoader;
			
			var data:XML = XML(uLoader.data);
			
			for each(var p:XML in data.aws:weather)
			{
				trace(p.aws.locations);
			}
		}
	}
}