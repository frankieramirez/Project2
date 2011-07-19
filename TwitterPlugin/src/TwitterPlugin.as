package
{
	import com.ramirez.events.TwitServiceEvent;
	import com.ramirez.services.TwitService;
	import com.ramirez.ui.TweetPanel;
	
	import flash.display.Sprite;
	
	[SWF(width="1024", height="768")]
	public class TwitterPlugin extends Sprite 
	{
		private var _tPanel:TweetPanel;
		
		public function TwitterPlugin()
		{
		} 
		
		public function initialize(xmlData:XML):void
		{	
			var tsvc:TwitService = new TwitService();
			tsvc.search(xmlData.text());
		}
		
		public function connect(e:TwitServiceEvent):void
		{
			_tPanel = new TweetPanel(e.data);
			this.addChild(_tPanel);
			_tPanel.addDetail();
		}
		
		public function disconnect():void 
		{
			this.removeChild(_tPanel);
		}
		
	}
}