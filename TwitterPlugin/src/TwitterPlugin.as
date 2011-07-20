package
{
	import com.Zambie.FlashBoard.Interface.IPlugin;
	import com.ramirez.events.TwitServiceEvent;
	import com.ramirez.services.TwitService;
	import com.ramirez.ui.TweetPanel;
	
	import flash.display.Sprite;
	
	[SWF(width="1024", height="768")]
	public class TwitterPlugin extends Sprite
	{
		private var _tPanel:TweetPanel;
		private var _pluginType:String = "TwitterPlugin";
		
		public function TwitterPlugin()
		{
		} 
		
		public function init(xmlData:XML):void
		{	
			var tsvc:TwitService = new TwitService();
			tsvc.search(xmlData.username.text());
			tsvc.addEventListener(TwitServiceEvent.DATA_LOADED,onDataLoaded);
			
		}
		
		public function onDataLoaded(e:TwitServiceEvent):void
		{
			_tPanel = new TweetPanel(e.data);
			this.addChild(_tPanel);
			_tPanel.addDetail();
		}
		
		public function get pluginType():String
		{
			return _pluginType;
		}
	}
}