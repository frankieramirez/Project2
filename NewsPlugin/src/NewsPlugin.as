package
{
	import com.events.NewsServiceEvent;
	import com.services.NewsService;
	import com.views.NewsView;
	
	import flash.display.Sprite;
 
	[SWF(width="1200", height="1024")]
	public class NewsPlugin extends Sprite
	{
		private var _newsVw:NewsView;
		private var _type:String;
		private var _slideDuration:Number;
		
		public function NewsPlugin()
		{
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
		
		public function get type():String
		{
			return _type;
		}
		
		public function get slideDuration():Number
		{
			return _slideDuration;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function set slideDuration(value:Number):void
		{
			_slideDuration = value;
		}


	}
}