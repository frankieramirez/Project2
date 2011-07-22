package
{
	import com.Zambie.FlashBoard.Interface.Plugin;
	import com.events.NewsServiceEvent;
	import com.services.NewsService;
	import com.views.NewsView;
	
	import flash.display.Sprite;
 	[SWF(width="1200", height="1200")]
	public class NewsPlugin extends Sprite
	{
		private var _newsVw:NewsView;
		
		public function NewsPlugin()
		{
			//this.fileName = "NewsPlugin.swf";	
			init();
		}
		
		public function init(xmlData:XML = null):void
		{
			_newsVw = new NewsView();
			addChild(_newsVw);
			
			var ns:NewsService = new NewsService();
			ns.addEventListener(NewsServiceEvent.NEWS_FOUND, onNewsFound);
			ns.load("http://hosted.ap.org/lineups/TOPHEADS-rss_2.0.xml?SITE=WYCHE&SECTION=HOME");
			//ns.load(String(xmlData.url));
		}
		
		private function onNewsFound(e:NewsServiceEvent):void
		{
			_newsVw.newsEvents = e.newsEvents;  
		}

	}
}