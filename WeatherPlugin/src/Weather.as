package
{
	import com.zambi.service.WeatherService;
	
	import flash.display.Sprite;
	
	public class Weather extends Sprite
	{
		public function Weather()
		{
			var service:WeatherService = new WeatherService();
			service.search();
		}
	}
}