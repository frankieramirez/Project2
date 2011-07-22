package com.Zambie.FlashBoard.Interface
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Fade extends Sprite
	{
		
		private var _obj:Sprite;
		private var _speed:Number;
		private var _alpha:Number;
		
		public function Fade()
		{
			
			
			
		}
		
		public function fadeOut(obj:Sprite, speed:Number):void {
			_obj = obj;
			_speed = speed;
			
			_obj.addEventListener(Event.ENTER_FRAME, startFadeOut);
			
		}
		
		private function startFadeOut(e:Event):void {
			
			if (e.currentTarget.alpha <= 0) {
				_obj.removeEventListener(Event.ENTER_FRAME, startFadeOut);
				dispatchCompleteEvent();
			} else {
				_obj.alpha -= _speed;
			}
			
		}
		
		public function fadeIn(obj:Sprite, speed:Number):void {
			
			_obj = obj;
			_obj.alpha = 0;
			_speed = speed;
			
			_obj.addEventListener(Event.ENTER_FRAME, startFadeIn);
			
		}
		
		private function startFadeIn(e:Event):void {
			
			if (_obj.alpha >= 1) {
				_obj.removeEventListener(Event.ENTER_FRAME, startFadeIn);
				dispatchCompleteEvent();
			} else {
				_obj.alpha += _speed;
			}
			
		}
		
		
		
		public function fadeOutTo(obj:Sprite, speed:Number, alph:Number):void {
			
			_obj = obj;
			_speed = speed;
			_alpha = alpha;
			_obj.addEventListener(Event.ENTER_FRAME, startFadeTo);
			
		}
		
		private function startFadeTo(e:Event):void {
			trace(_obj);
			if (_obj.alpha <= _alpha) {
				
				_obj.removeEventListener(Event.ENTER_FRAME, startFadeTo);
				dispatchCompleteEvent();
				
			} else {
				
				_obj.alpha -= _speed;
				
			}
			
		}
		
		private function dispatchCompleteEvent():void {
			
			var newEvt:Event = new Event("fade complete");
			dispatchEvent(newEvt);
			
		}
	}
}