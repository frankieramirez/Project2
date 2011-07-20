package com.ramirez.ui
{
	import com.ramirez.events.TwitServiceEvent;
	import com.ramirez.vo.InfoVO;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import libs.TweetPanelBase;
	
	public class TweetPanel extends TweetPanelBase
	{
		private var _data:Array;
		
		public function TweetPanel(data:Array)
		{
			super();
			_data = data;			
		}
		
		public function addDetail():void
		{
			var i:int = 0;
			
			for each(var vo:InfoVO in _data)
			{
				if(i == 0)
				{
					this.tfUsername.text = vo.name;
					this.tfTweet.text = vo.tweet;
					this.tfTime.text = vo.timeCreated;
					var ld:Loader = new Loader();
					ld.load(new URLRequest(vo.img_url));
					ld.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad);
				}
				else
				{
					var dv:DetailView = new DetailView(vo.name,vo.tweet,vo.img_url,vo.timeCreated);
					this.addChild(dv);
					dv.y = 160 + (dv.height + 20) * i;
					dv.x = 100;
				}
				i++;
			}
			
		}
		
		private function onLoad(e:Event):void
		{
			this.imgBase.addChild(e.currentTarget.content);
			e.currentTarget.content.scaleX = e.currentTarget.content.scaleY = 2;
			Bitmap(e.currentTarget.content).smoothing = true;
		}
		
	}
}