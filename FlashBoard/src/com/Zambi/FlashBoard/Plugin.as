package com.Zambi.FlashBoard
{
	
	import com.Zambie.FlashBoard.Interface.IPlugin;
	import com.jworkman.Effects.Fade;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	public class Plugin extends Sprite
	{
		
		private var _duration:uint;
		private var _fader:Fade;
		
		public var fileName:String = "TimeOverlay.swf";
		
		public function Plugin():void {
			
			this.alpha = 0;
			
		}
		
		public function connect():void {
			
			_fader.fadeIn(this, .05);
			
		}
		
		public function disconnect():void {
			
			_fader.fadeOut(this, .08);
			
		}
		
		public function init(xmlData:XML):void {
			
			
			throw new Error('your plugin must override the init function');
		}
		
		
		
	}
}