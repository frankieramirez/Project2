package
{
	import com.ramirez.services.TwitService;
	
	import flash.display.Sprite;
	
	public class TwitterPlugin extends Sprite
	{
		public function TwitterPlugin()
		{
			
		}
		
		public function connect():void
		{
			
		}
		
		public function disconnect():void
		{
			
		}
		
		public function initialize(keyword:XML):void
		{	
			var tsvc:TwitService = new TwitService();
			tsvc.search(keyword.text());
		}
	}
}