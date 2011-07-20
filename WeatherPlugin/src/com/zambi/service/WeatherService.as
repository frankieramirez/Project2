package com.zambi.service
{
	import com.zambi.event.WeatherServiceEvent;
	import com.zambi.vo.InfoVO;
	import com.zambi.vo.WeatherVO;
	
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
		private static const DAYF:String = "2";
		
		public function WeatherService(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function search(zip:String = "32707"):void
		{
			var uVars:URLVariables = new URLVariables();
			uVars.key = API_KEY;
			uVars.par = PAR;
			uVars.dayf = DAYF;
			uVars.prod = "xoap";
			uVars.cc = "*";
			
			var uReq:URLRequest = new URLRequest();
			uReq.data = uVars;
			uReq.url = "http://xoap.weather.com/weather/local/" + zip;
			
			var uLoader:URLLoader = new URLLoader();
			uLoader.addEventListener(Event.COMPLETE, onSearchComplete);
			uLoader.load(uReq);
		}
		
		private function onSearchComplete(e:Event):void
		{
			var nameSpace:Namespace = new Namespace();
			
		//	trace(e.currentTarget);
			var uLoader:URLLoader = e.currentTarget as URLLoader;
			
			var data:XML = XML(uLoader.data);
			
			//trace(data.dayf);
			//trace(data);
			//trace(data.cc.dewp);
			//trace(data);
			var info:InfoVO = new InfoVO();
			info.dewPoint = data.cc.dewp;
			info.feelsLike = data.cc.flik;
			info.iUV = data.cc.uv.i;
			info.tUV = data.cc.uv.t;
			info.visibility = data.cc.vis;
			info.humid = data.cc.hmid;
			info.temp = data.cc.tmp;
			info.windSpeed = data.cc.wind.s;
			info.windDir = data.cc.wind.t;
			info.sunrise = data.loc.sunr;
			info.sunset = data.loc.suns;
			trace(data.cc.humid);
			
			//trace(data..day.@d);
			//trace(data.dayf.length);
			var loopLength:int = int(DAYF);
			var weatherArray:Array = [];
			for(var i:int = 0; i < loopLength; i++)
			{
				var wVO:WeatherVO = new WeatherVO();
				wVO.dayCondition = data.dayf.day[i].part[0].t;
				wVO.dayHumidity = data.dayf.day[i].part[0].hmid;
				wVO.dayPrecip = data.dayf.day[i].part[0].ppcp;
				wVO.dayWind = data.dayf.day[0].part[0].wind.s;
				wVO.dayWindDir = data.dayf.day[0].part[0].wind.t;
				wVO.dayTemp = data.dayf.day[i].hi;
				wVO.daySun = data.dayf.day[i].sunr;
				
				wVO.nightCondition = data.dayf.day[i].part[1].t;
				wVO.nightHumidity = data.dayf.day[i].part[1].hmid;
				wVO.nightPrecip = data.dayf.day[i].part[1].ppcp;
				wVO.nightWind = data.dayf.day[0].part[0].wind.s;
				wVO.nightWindDir = data.dayf.day[0].part[0].wind.t;
				wVO.nightTemp = data.dayf.day[i].low;
				wVO.nightSun = data.dayf.day[i].suns;
				weatherArray.push(wVO);
			}
			
			info.weatherVOs = weatherArray;
			//trace(data.dayf.day[0].hmid);
			/*
			info.todayTemp = data.dayf.day[0].hi;
			info.todayHumid = data.dayf.day[0].part[0].hmid;
			info.todayPrecip = data.dayf.day[0].part[0].ppcp;
			info.todayCondition = data.dayf.day[0].part[0].t;
			info.todayWind = data.dayf.day[0].part[0].wind.s;
			info.todayWindDir = data.dayf.day[0].part[0].wind.t;
			
			info.tonightTemp = data.dayf.day[0].low;
			info.tonightHumid = data.dayf.day[0].part[1].hmid;
			info.tonightPrecip = data.dayf.day[0].part[1].ppcp;
			info.tonightCondition = data.dayf.day[0].part[1].t;
			info.tonightWind = data.dayf.day[0].part[1].wind.s;
			info.tonightWindDir = data.dayf.day[0].part[1].wind.t;
			*/
			/* = = = = = = = = = = = = = = = = = = = = = = */
			/*
			info.tomorrowTemp = data.dayf.day[1].hi;
			info.tomorrowHumid = data.dayf.day[1].part[0].hmid;
			info.tomorrowPrecip = data.dayf.day[1].part[0].ppcp;
			info.tomorrowCondition = data.dayf.day[1].part[0].t;
			info.tomorrowWind = data.dayf.day[1].part[0].wind.s;
			info.tomorrowWindDir = data.dayf.day[1].part[0].wind.t;
			
			info.tomorrowNightTemp = data.dayf.day[1].low;
			info.tomorrowNightHumid = data.dayf.day[1].part[1].hmid;
			info.tomorrowNightPrecip = data.dayf.day[1].part[1].ppcp;
			info.tomorrowNightCondition = data.dayf.day[1].part[1].t;
			info.tomorrowNightWind = data.dayf.day[1].part[1].wind.s;
			info.tomorrowNightWindDir = data.dayf.day[1].part[1].wind.t;
			
			info.todaySunrise = data.dayf.day[0].sunr;
			info.tonightSunset = data.dayf.day[0].suns;
			info.tomorrowSunrise = data.dayf.day[1].sunr;
			info.tomorrowNightSunset = data.dayf.day[1].suns;
			*/
				
			var event:WeatherServiceEvent = new WeatherServiceEvent(WeatherServiceEvent.DATA_LOADED);
			event.data = info;
			dispatchEvent(event);
		}
	}
}