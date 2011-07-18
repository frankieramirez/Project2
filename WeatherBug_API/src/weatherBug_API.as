package
{
	import com.zambi.service.WeatherService;
	
	import flash.display.Sprite;
	
	public class weatherBug_API extends Sprite
	{
		public function weatherBug_API()
		{
			var weather:WeatherService = new WeatherService();
			weather.search();
		}
		
		public function connect():void
		{
			
		}
		
		public function disconnect():void
		{
			
		}
		
		
	}
}