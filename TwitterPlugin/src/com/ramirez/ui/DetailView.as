package com.ramirez.ui
{
	import com.ramirez.vo.InfoVO;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import libs.DetailViewBase;
	
	public class DetailView extends DetailViewBase
	{
		public function DetailView(username:String,tweet:String,img:String,time:String)
		{
			super();
			this.tfUsername.text = username;
			this.tfTweet.text = tweet;
			this.tfTime.text = time;
			
			var ld:Loader = new Loader();
			ld.load(new URLRequest(img));
			ld.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad);
		}
		
		private function onLoad(e:Event):void
		{
			this.imgBase.addChild(e.currentTarget.content);
		}
		
	}
}