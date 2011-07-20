package com.jworkman.ui
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class Button
	{
		private var _button:MovieClip;
		private var _dir:int = 1;
		
		public function Button(button:MovieClip)
		{
			super();
			_button = button;
			
			_button.stop();
			_button.x = 15;
			_button.mouseChildren = false;
			_button.buttonMode = true;
			_button.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			_button.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		}
		
		public function mouseOver(evt:MouseEvent):void {
			
			_button.removeEventListener(Event.ENTER_FRAME, rollOutButton);
			_button.addEventListener(Event.ENTER_FRAME, rollOverButton);
			
		}
		
		public function rollOverButton(evt:Event):void {
			
			if (_button.currentFrame <= (_button.totalFrames - 1)) {
				
				_button.gotoAndStop(_button.currentFrame + 1);
				
				trace(_button.totalFrames);
				
			} else {
				_button.removeEventListener(Event.ENTER_FRAME, rollOverButton);
			}
			
		}
		
		private function mouseOut(evt:MouseEvent):void {
			
			_button.removeEventListener(Event.ENTER_FRAME, rollOverButton);
			_button.addEventListener(Event.ENTER_FRAME, rollOutButton);
			
		}
		
		private function rollOutButton(evt:Event):void {
			
			if (_button.currentFrame >= (2)) {
				
				
				_button.gotoAndStop(_button.currentFrame - 1);
				
				trace(_button.totalFrames);
				
			} else {
				_button.removeEventListener(Event.ENTER_FRAME, rollOutButton);
			}
			
		}
		
		
		
	}
}