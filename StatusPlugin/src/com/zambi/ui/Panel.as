package com.zambi.ui
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import libs.DetailViewBase;
	import libs.PanelBase;
	
	public class Panel extends PanelBase
	{
		private var _dv:DetailViewBase;
		
		override public function Panel()
		{
			super();
		}
		
		public function detailView(usernames:Array,fullNames:Array):void
		{
			for each(var username:String in usernames)
			{
				_dv = new DetailViewBase();
				this.addChild(_dv);
				_dv.tfUsername.text = username;
				
				var ld:Loader = new Loader();
				var rq:URLRequest = new URLRequest("http://big.oscar.aol.com/"+username+"?on_url=http://66.192.104.111/~jmadsen/online_status_imgs/chatonline_small1.jpeg&off_url=http://66.192.104.111/~jmadsen/online_status_imgs/chatoffline_small1.jpeg");
				ld.load(rq);
				ld.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			}
			
			for each(var fullName:String in fullNames)
			{
				_dv.tfFullName.text = fullName;
			}
		}
		
		private function onComplete(e:Event):void
		{
			_dv.imgBase.addChild(e.currentTarget.content);
		}
	}
}