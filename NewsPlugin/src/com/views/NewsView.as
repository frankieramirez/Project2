package com.views
{
	import com.utils.TextExcerpt;
	
	import flash.display.Sprite;
	
	import libs.NewsViewBase;
	
	public class NewsView extends NewsViewBase
	{
		private var _newsEvents:Array = [];
		private var _displayedItems:Array = [];
		
		public function NewsView()
		{
			super();
		}
		
		private function init():void
		{
		}

		public function set newsEvents(value:Array):void
		{
			_newsEvents = value;
			
			TextExcerpt.setFixedText(tfTitle, _newsEvents[0].title, false);
			
			//tfTitle.text = _newsEvents[0].title;
			tfSummary.text = _newsEvents[0].summary;
			tfDate.text = _newsEvents[0].published;
			
			tfUpcomingTitle1.text = _newsEvents[1].title;
			tfUpcomingDate1.text = _newsEvents[1].published;
			
			tfUpcomingTitle2.text = _newsEvents[2].title;
			tfUpcomingDate2.text = _newsEvents[2].published;
			
			tfUpcomingTitle3.text = _newsEvents[3].title;
			tfUpcomingDate3.text = _newsEvents[3].published;

		}

	}
}