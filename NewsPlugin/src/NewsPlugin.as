package
{
	import com.events.NewsServiceEvent;
	import com.services.NewsService;
	import com.views.NewsView;
	
	import flash.display.Sprite;
	
	[SWF(width="1024", height="1024")]
	public class NewsPlugin extends Sprite
	{
		private var _newsVw:NewsView;
		
		public function NewsPlugin()
		{
		}
		
		public function connect():void
		{
			
		}
		
		public function disconnect():void
		{
			
		}
		
		public function init(xml:XML):void
		{
			_newsVw = new NewsView();
			addChild(_newsVw);
			
			var url:String = XML(xml.data.url);
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