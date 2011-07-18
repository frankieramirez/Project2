package
{
	import com.ramirez.services.TwitService;
	import com.ramirez.ui.TweetPanel;
	
	import flash.display.Sprite;
	
	[SWF(width="1080", height="800")]
	public class TwitterPlugin extends Sprite
	{
		public function TwitterPlugin()
		{
			initialize("drsalvan");
		}
		
		public function connect():void
		{
			var tPanel:TweetPanel = new TweetPanel();
			this.addChild(tPanel);
		}
		
		public function disconnect():void
		{
			//this.removeChild(tPanel);
		}
		
		public function initialize(keyword:String):void
		{	
			var tsvc:TwitService = new TwitService();
			tsvc.search(keyword);
			connect();
		}
	}
}