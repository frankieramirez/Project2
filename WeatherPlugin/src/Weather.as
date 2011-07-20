package
{
	import com.zambi.event.WeatherServiceEvent;
	import com.zambi.service.WeatherService;
	import com.zambi.vo.InfoVO;
	import com.zambi.vo.WeatherVO;
	
	import flash.display.Sprite;
	
	import libs.mainPanelBase;
	import libs.panelBase;
	[SWF(width="800", height="600")]
	public class Weather extends Sprite
	{
		public function Weather()
		{
			init();
		}
		
		public function init(xml:XML = null):void
		{
			
			var service:WeatherService = new WeatherService();
			service.search();
			service.addEventListener(WeatherServiceEvent.DATA_LOADED, onLoaded);
			
		}
		
		private function onLoaded(e:WeatherServiceEvent):void
		{
			var info:InfoVO = e.data;
			
			var today:mainPanelBase = new mainPanelBase();
			today.condition.text = info.weatherVOs[0].dayCondition;
			today.humidity.text = info.humid + "%";
			today.precip.text = info.weatherVOs[0].dayPrecip + "%";
			today.currentTemp.text = info.temp;
			today.wind.text = info.windDir + " at " + info.windSpeed + "mph";
			today.uv.text = info.iUV + " - " + info.tUV;
			today.sun.text = info.sunrise;
			today.visibility.text = info.visibility + "mi";
			today.rise_set.text = "Sunrise";
			
			addChild(today);
			today.scaleX = today.scaleY = .6;
			today.x = 300;
			today.y = 75;
			
			for(var i:uint = 0; i < info.weatherVOs.length; i++)
			{
				var night:panelBase = new panelBase();
				night.condition.text = info.weatherVOs[i].nightCondition;
				night.currentTemp.text = info.weatherVOs[i].nightTemp;
				night.wind.text = info.weatherVOs[i].nightWindDir + " at " + info.weatherVOs[0].nightWind + "mph";
				night.humidity.text = info.weatherVOs[i].nightHumidity + "%";
				night.sun.text = info.weatherVOs[i].nightSun;
				night.precip.text = info.weatherVOs[i].nightPrecip + "%";
				night.rise_set.text = "Sunrise";
				addChild(night);
				night.scaleX = night.scaleY = .5;
				night.x = 400 * i + 100;
				night.y = 225;
			}
			
			var day:panelBase = new panelBase();
			day.condition.text = info.weatherVOs[0].dayCondition;
			day.currentTemp.text = info.weatherVOs[0].dayTemp;
			day.wind.text = info.weatherVOs[0].dayWindDir + " at " + info.weatherVOs[0].dayWind + "mph";
			day.humidity.text = info.weatherVOs[0].dayHumidity + "%";
			day.sun.text = info.weatherVOs[0].daySun;
			day.precip.text = info.weatherVOs[0].dayPrecip + "%";
			day.rise_set.text = "Sunset";
			addChild(day);
			day.scaleX = day.scaleY = .5;
			day.x = 300;
			day.y = 225;
			
		}
	}
}