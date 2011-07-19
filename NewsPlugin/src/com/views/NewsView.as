package com.views
{
	import flash.display.Sprite;
	
	public class NewsView extends Sprite
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
			
			for(var i:int; i < _newsEvents.length; i++)
			{
				var ni:NewsViewItem = new NewsViewItem(_newsEvents[i]);
				ni.y += 30*i;
				addChild(ni);
				_displayedItems.push(ni);
			}
		}

	}
}