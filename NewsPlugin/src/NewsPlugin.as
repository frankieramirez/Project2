package
{
	import com.events.NewsServiceEvent;
	import com.services.NewsService;
	import com.views.NewsView;
	
	import flash.display.Sprite;
	
	public class NewsPlugin extends Sprite
	{
		private var _newsVw:NewsView;
		
		public function NewsPlugin()
		{
			init();
		}
		
		public function connect():void
		{
			
		}
		
		public function disconnect():void
		{
			
		}
		
		public function init():void
		{
			_newsVw = new NewsView();
			addChild(_newsVw);
			
			var url:String = "http://hosted.ap.org/lineups/TOPHEADS-rss_2.0.xml?SITE=WYCHE&SECTION=HOME";
			var ns:NewsService = new NewsService();
			ns.addEventListener(NewsServiceEvent.NEWS_FOUND, onNewsFound);
			ns.load(url);
		}
		
		private function onNewsFound(e:NewsServiceEvent):void
		{
			_newsVw.newsEvents = e.newsEvents;
		}
		
	}
}