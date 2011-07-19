package
{
	import com.ramirez.events.TwitServiceEvent;
	import com.ramirez.services.TwitService;
	import com.ramirez.ui.TweetPanel;
	
	import flash.display.Sprite;
	
	[SWF(width="1080", height="800")]
	public class TwitterPlugin extends Sprite 
	{
		public function TwitterPlugin()
		{
		} 
		
		public function connect(e:TwitServiceEvent):void
		{
			var tPanel:TweetPanel = new TweetPanel(e.data);
			this.addChild(tPanel);
			tPanel.addDetail();
		}
		
		public function disconnect():void 
		{
			//this.removeChild(tPanel);
		}
		
		public function initialize(xmlData:XML):void
		{	
			var tsvc:TwitService = new TwitService();
			tsvc.search(xmlData.text());
			tsvc.addEventListener(TwitServiceEvent.DATA_LOADED, connect);
		}
	}
}