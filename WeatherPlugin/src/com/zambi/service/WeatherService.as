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
		private static const API_KEY:String = "667e89477893704a";
		private static const PAR:String = "1267682644";
		
		public function WeatherService(target:IEventDispatcher=null)
		{
			super(target);
		}
		//http://xoap.weather.com/weather/local/32707?cc=*&dayf=2&
		//link=xoap&prod=%20xoap&par=1267682644&key=667e89477893704a
		public function search(zip:String = "32707"):void
		{
			var uVars:URLVariables = new URLVariables();
			uVars.key = API_KEY;
			uVars.par = PAR;
			uVars.dayf = "2";
			
			var uReq:URLRequest = new URLRequest();
			uReq.data = uVars;
			uReq.url = "http://xoap.weather.com/weather/local/" + zip;
			
			var uLoader:URLLoader = new URLLoader();
			uLoader.addEventListener(Event.COMPLETE, onSearchComplete);
			uLoader.load(uReq);
		}
		
		private function onSearchComplete(e:Event):void
		{
			
			trace(e.currentTarget);
			var uLoader:URLLoader = e.currentTarget as URLLoader;
			
			var data:XML = XML(uLoader.data);
			
			trace(data.dayf);
			
			
			
		}
	}
}