package com.jworkman.imageloader
{
	import flash.display.Bitmap;
	import flash.events.Event;
	
	public class EasyImageLoaderEvent extends Event
	{
		
		public var loadedImage:Bitmap;
		public static const IMAGE_LOADED:String = "Image Loaded";
		
		public function EasyImageLoaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			
			return new EasyImageLoaderEvent(type, bubbles, cancelable);
			
		}
		
	}
}