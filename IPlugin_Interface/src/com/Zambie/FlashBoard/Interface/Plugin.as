package com.Zambie.FlashBoard.Interface
{
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	public class Plugin extends Sprite
	{
		
		private var _duration:uint = 1;
		private var _fader:Fade; 
		private var _timer:Timer;
		public static const TIME_DONE:String = "Time over";
		
		public var fileName:String;
		
		public function Plugin():void {
			
			
			
		}
		
		public function connect():void {
			
			_fader.fadeIn(this, .05);
			
			if (_timer) {
				
				_timer.removeEventListener(TimerEvent.TIMER, onTimeUp);
				_timer.reset();
				_timer.addEventListener(TimerEvent.TIMER, onTimeUp);
				_timer.start();
				
			} else {
				
				_timer = new Timer(_duration * 1000);
				_timer.addEventListener(TimerEvent.TIMER, onTimeUp);
				
			}
			
		}
		
		private function onTimeUp(e:TimerEvent):void {
			
			_timer.stop();
			var evt:Event = new Event(TIME_DONE);
			this.dispatchEvent(evt);
			
		}
		
		
		public function disconnect():void {
			
			_fader.fadeOut(this, .08);
			
			
			
		}
		
		public function init(xmlData:XML):void {
			
			
			throw new Error('your plugin must override the init function');
		}
		
		
		
	}
}