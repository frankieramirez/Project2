package com.services
{
	import com.VO.NewsVO;
	import com.events.NewsServiceEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class NewsService extends EventDispatcher
	{
		private var _newsEvents:Array = [];
		
		public function NewsService()
		{
			super();
		}
		
		public function load(url:String):void
		{
			var ul:URLLoader = new URLLoader();
			ul.load(new URLRequest(url));
			ul.addEventListener(Event.COMPLETE, onLoadComplete);
			ul.addEventListener(IOErrorEvent.IO_ERROR, onLoadFail);
		}
		
		private function onLoadComplete(e:Event):void
		{
			var xmlData:XML = XML(e.currentTarget.data);
			trace(xmlData);
			for each (var item:XML in xmlData.channel.item)
			{
				var nv:NewsVO = new NewsVO();
				nv.title = item.title;
				nv.summary = item.description;
				nv.published = item.pubDate;
				_newsEvents.push(nv);
			}
			
			var evt:NewsServiceEvent = new NewsServiceEvent(NewsServiceEvent.NEWS_FOUND);
			evt.newsEvents = _newsEvents;
			dispatchEvent(evt);
		}
		
		private function onLoadFail(e:Event):void
		{
			
		}
	}
}