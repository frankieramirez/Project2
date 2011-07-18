package com.salvador.service
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLVariables;
	
	public class WeatherService extends EventDispatcher
	{
		private static const API_KEY:String = "A5477512792";
		private var _infoVOs:Array = [];
		
		public function WeatherService(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function search():void
		{
			var uVars:URLVariables = new URLVariables();
		}
	}
}