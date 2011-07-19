package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	[SWF(width="1024", height="768")]
	public class ImagePlugin extends Sprite
	{
		private var _ld:Loader;
		
		public function ImagePlugin()
		{
			
		}
		
		public function initialize(xmlData:XML):void
		{
			_ld = new Loader();
			_ld.load(new URLRequest(xmlData.text());
			_ld.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
		}
		
		private function onComplete(e:Event):void
		{
			
		}
		
		public function connect():void
		{
			this.addChild(_ld.content);
		}
		
		public function disconnect():void
		{
			this.removeChild(_ld.content);
		}
		
	}
}