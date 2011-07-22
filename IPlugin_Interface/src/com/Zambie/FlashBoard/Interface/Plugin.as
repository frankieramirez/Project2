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
		
		private var _duration:uint;
		private var _fader:Fade; 
		private var _timer:Timer;
		private var _transitions:Array;
		public static const TIME_DONE:String = "Time over";
		
		private var _fileName:String;
		
		public function set transitions(value:Array):void
		{
			_transitions = value;
		}

		public function set duration(value:uint):void
		{
			_duration = value;
		}

		public function set fileName(str:String):void
		{
			_fileName = str;
		}

		public function get fileName():String
		{
			return _fileName;
		}

		public function get duration():uint
		{
			return _duration;
		}

		public function Plugin():void {
			
			_fader = new Fade();
			
			this.alpha = 1;
			
		}
		
		
		
		/*private function onTimeUp(e:TimerEvent):void {
			
			_timer.stop();
			var evt:Event = new Event(TIME_DONE);
			this.dispatchEvent(evt);
			
		}*/
		
		
		
		
		public function init(xmlData:XML):void {
			
			
			throw new Error('your plugin must override the init function');
			
			
		}
		
		
		
	}
}