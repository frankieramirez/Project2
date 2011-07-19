package com.views
{
	import com.VO.NewsVO;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class NewsViewItem extends Sprite
	{
		private var _news:NewsVO;
		private var _tf:TextField;
		
		public function NewsViewItem(news:NewsVO)
		{
			super();
			
			_news = news;

			_tf = new TextField();
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_tf.width = 200;
			addChild(_tf);
			update();
			//TODO find out if this item is the first, and if so change it to the next frame
		}
		
		private function update():void
		{
			_tf.text = _news.title;
		}
		
		public function set news(value:NewsVO):void
		{
			_news = value;
		}

	}
}