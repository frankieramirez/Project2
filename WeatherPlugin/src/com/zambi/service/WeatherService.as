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
		private var _infoVOs:Array = [];
		
		public function WeatherService(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function search(zip:String = "32707"):void
		{
			//get station id
			//get weather
			var uVars:URLVariables = new URLVariables();
			uVars.key = API_KEY;
			uVars.dayf = "2";
			uVars.prod = "xoap";
			uVars.par = PAR;
			//uVars.
			
			var uReq:URLRequest = new URLRequest();
			uReq.data = uVars;
			uReq.url = "http://xoap.weather.com/weather/local/" + zip
			//uReq.url = "http://" +  API_KEY + ".api.wxbug.net/getLocationsXML.aspx";
			//uReq.url = "http://" + API_KEY + ".isapi.wxbug.net/forecastISAPI/ForecastISAPI.cgi";
			
			var uLoader:URLLoader = new URLLoader();
			uLoader.addEventListener(Event.COMPLETE, onSearchComplete);
			uLoader.load(uReq);
			
		}
		
		private function onSearchComplete(e:Event):void
		{
			//var nameSpace:Namespace = new Namespace();
			trace("works");
			var uLoader:URLLoader = e.currentTarget as URLLoader;
			
			var data:XML = XML(uLoader.data);
			
			trace(data.dayf);
			
			
			
		}
	}
}