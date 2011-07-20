package com.jworkman.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class SliderManager extends EventDispatcher
	{
		
		private var _handle:Sprite;
		private var _track:Sprite;
		
		private var _perc:Number = 0;
		
		public function SliderManager()
		{
		}
		
		

		public function setupAssets(handle:Sprite, track:Sprite):void {
			
			_track = track;
			_handle = handle;
			
			_handle.buttonMode = true;
			_handle.mouseChildren = false;
			
			_handle.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_handle.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
		}
		
		private function onMouseDown(evt:MouseEvent):void {
			
			_handle.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			_handle.startDrag(false, new Rectangle(0,0,(_track.width - _handle.width), 0));
			
			_handle.addEventListener(Event.ENTER_FRAME, calculatePercent);
			
		}
		
		
		
		private function onMouseUp(evt:MouseEvent):void {
			
			_handle.stopDrag();
			
			_handle.removeEventListener(Event.ENTER_FRAME, calculatePercent);
			
			_handle.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			
		}
		
		private function calculatePercent(evt:Event):void {
			
			var percent:Number = _handle.x / (_track.width - _handle.width);
			
			if (percent > .995) {
				percent = 1;
			} 
			
			if (_perc != percent) {
				_perc = percent;
				var evt:Event = new Event(Event.CHANGE);
				this.dispatchEvent(evt);
			}
			
			
		}
		
		public function get perc():Number
		{
			return _perc;
		}
		
		public function updateTrack(percent:Number):void {
			
			_perc = percent;
			_handle.x = percent * (_track.width - (_handle.width/2));
			
		}
		
		
		
		
	}
}