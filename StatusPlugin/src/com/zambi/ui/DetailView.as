package com.zambi.ui
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import libs.DetailViewBase;
	
	public class DetailView extends DetailViewBase
	{
		public function DetailView(username:String,fullName:String)
		{
			super();
			this.tfFullName.text = fullName;
			this.tfUsername.text = username;
			
			var ld:Loader = new Loader();
			var rq:URLRequest = new URLRequest("http://big.oscar.aol.com/"+username+"?on_url=http://66.192.104.111/~jmadsen/online_status_imgs/chatonline_small1.jpeg&off_url=http://66.192.104.111/~jmadsen/online_status_imgs/chatoffline_small1.jpeg");
			ld.load(rq);
			ld.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoad);
		}
		
		private function onLoad(e:Event):void
		{
			this.imgBase.addChild(e.currentTarget.content);
		}
	}
}