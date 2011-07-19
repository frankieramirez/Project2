package
{
	import com.zambi.event.WeatherServiceEvent;
	import com.zambi.service.WeatherService;
	import com.zambi.vo.InfoVO;
	
	import flash.display.Sprite;
	
	import libs.panelBase;
	
	public class Weather extends Sprite
	{
		public function Weather()
		{
			var service:WeatherService = new WeatherService();
			service.search();
			service.addEventListener(WeatherServiceEvent.DATA_LOADED, onLoaded);
		}
		
		private function onLoaded(e:WeatherServiceEvent):void
		{
			var infoVO:InfoVO = e.data;
			
			var tonightPanel:panelBase = new panelBase();
			tonightPanel.condition.text = infoVO.tonightCondition;
			tonightPanel.currentTemp.text = infoVO.tonightTemp;
			tonightPanel.wind.text = infoVO.tonightWindDir + " at " + infoVO.tonightWind + "mph";
			tonightPanel.humidity.text = infoVO.tonightHumid;
			tonightPanel.sun.text = infoVO.tonightSunset;
		}
	}
}