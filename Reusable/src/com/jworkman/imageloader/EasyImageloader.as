package com.jworkman.imageloader
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	
	[Event(name="imageLoaded", type="com.jworkman.EasyImageLoaderEvent")]
	public class EasyImageloader extends EventDispatcher
	{
		public function EasyImageloader(path:String)
		{
			
			var ur:URLRequest = new URLRequest(path);
			var loader:Loader = new Loader();
			
			loader.load(ur);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			
		}
		
		private function onLoadComplete(e:Event):void {
			
			var b:Bitmap = (e.currentTarget as LoaderInfo).content as Bitmap;
			
			var evt:EasyImageLoaderEvent = new EasyImageLoaderEvent(EasyImageLoaderEvent.IMAGE_LOADED);
			
			evt.loadedImage = b;
			
			this.dispatchEvent(evt);
			
		}
	}
}