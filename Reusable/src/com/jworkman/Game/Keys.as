package com.jworkman.Game
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;

	public class Keys
	{
		
		public static var keyPressed:Array;
		
		public function Keys()
		{
			
			
			
		}
		
		public static function init(st:Stage):void {
			
			keyPressed = [];
			for(var i:int; i < 100; i++) {
				
				keyPressed[i] = 0;
				
			}
			
			st.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			st.addEventListener(KeyboardEvent.KEY_UP, onUp);
			
		}
		
		private static function onDown(e:KeyboardEvent):void {
			
			keyPressed[e.keyCode] = 1;
			
		}
		
		private static function onUp(e:KeyboardEvent):void {
			
			keyPressed[e.keyCode] = 0;
			
		}
		
	}
}