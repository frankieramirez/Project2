package com.jworkman.Effects
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Fade extends Sprite
	{
		
		private var _obj:Sprite;
		private var _bitmap:Bitmap;
		private var _speed:Number;
		private var _alpha:Number;
		private var _fadeTo:Number;
		
		public function Fade()
		{
			
			
			
		}
		
		public function fadeOut(obj:Sprite, speed:Number):void {
			_obj = obj;
			_speed = speed;
			
			_obj.addEventListener(Event.ENTER_FRAME, startFadeOut);
			
		}
		
		public function fadeInBitmap(obj:Bitmap, speed:Number, fadeTo:Number = 1):void {
			
			obj.alpha = 0;
			_fadeTo = fadeTo;
			_bitmap = obj;
			_speed = speed;
			
			_bitmap.addEventListener(Event.ENTER_FRAME, startFadeInBitmap);
			
		}
		
		private function startFadeInBitmap(e:Event):void {
			
			if (_bitmap.alpha >= _fadeTo) {
				_bitmap.removeEventListener(Event.ENTER_FRAME, startFadeInBitmap);
				dispatchCompleteEvent();
			} else {
				_bitmap.alpha += _speed;
			}
			
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