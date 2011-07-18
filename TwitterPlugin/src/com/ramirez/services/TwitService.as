package com.ramirez.services
{
	import com.ramirez.events.TwitServiceEvent;
	import com.ramirez.vo.InfoVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import json.JSON;
	[Event(type="com.ramirez.events.TwitServiceEvent",name="dataLoaded")]
	public class TwitService extends EventDispatcher
	{
		public function TwitService(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function search(keyword:String):void
		{
			// SEARCH FOR KEYWORD, LISTEN FOR COMPLETION
			var uReq:URLRequest = new URLRequest();
			uReq.url = "http://search.twitter.com/search.json?q=" + keyword;
			var uLoad:URLLoader = new URLLoader();
			uLoad.load(uReq);
			uLoad.addEventListener(Event.COMPLETE, onSearchComplete);
			uLoad.addEventListener(IOErrorEvent.IO_ERROR,onSearchFail);
		}
		
		private function onSearchComplete(e:Event):void
		{	
			// ONCE COMPLETE, PARSE DATA AND PUSH TO ARRAY; DISPATCH EVENT
			e.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR,onSearchFail);
			
			var uLoader:URLLoader = e.currentTarget as URLLoader;
			
			var returnArray:Array = [];
			
			var data:Object = JSON.decode(e.target.data);
			trace(e.target.data);
			
			var i:int = 0;
			for each(var o:Object in data.results)
			{
				if (i<5) 
				{
					var iVo:InfoVO = new InfoVO();
					iVo.name = o.from_user;
					iVo.img_url = o.profile_image_url;
					iVo.tweet = o.text;
					iVo.timeCreated = o.created_at;
					
					returnArray.push(iVo);
					i++;
				}
			}
			
			var evt:TwitServiceEvent = new TwitServiceEvent(TwitServiceEvent.DATA_LOADED);
			evt.data = returnArray;
			dispatchEvent(evt);
		}
		
		private function onSearchFail(e:IOErrorEvent):void
		{
			var evt:TwitServiceEvent = new TwitServiceEvent(TwitServiceEvent.LOAD_FAILED);
			dispatchEvent(evt);
		}
	}
}