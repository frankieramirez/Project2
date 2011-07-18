package com.ramirez.ui
{
	import com.ramirez.events.TwitServiceEvent;
	import com.ramirez.vo.InfoVO;
	
	import libs.TweetPanelBase;
	
	public class TweetPanel extends TweetPanelBase
	{
		public function TweetPanel()
		{
			super();
			
			this.addEventListener(TwitServiceEvent.DATA_LOADED, onDataLoaded);
		}
		
		private function onDataLoaded(e:TwitServiceEvent):void
		{
			var i:int = 0;
			
			for each(var vo:InfoVO in e.data)
			{
				if(i == 0)
				{
					this.tfUsername.text = vo.name;
				}
				else
				{
					var dv:DetailView = new DetailView(vo.name,vo.tweet,vo.img_url,vo.timeCreated);
					this.addChild(dv);
					dv.y = (dv.height) * i;
					i++;
				}
			}
		}
	}
}