package com.jworkman.imageloader
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class ImageViewer extends Sprite
	{
		
		private var _pictureList:Array = [];
		private var _bitmapList:Array = [];
		private var _currentPictureNumber:int = 0;
		
		public function ImageViewer(listOfImages:Array) 
		{
			
			_pictureList = listOfImages;
			
			var easy:EasyImageloader;
			for each(var pic:String in _pictureList) {
				
				easy = new EasyImageloader(pic);
				easy.addEventListener(EasyImageLoaderEvent.IMAGE_LOADED, onImageLoaded); 
				
			}
			
		}
		
		private function onImageLoaded(e:EasyImageLoaderEvent):void {
			
			//this.addChild(e.loadedImage);
			_bitmapList.push(e.loadedImage);
			if (_bitmapList.length == _pictureList.length) {
				
				displayImages();
				
			}
			
		}
		
		private function displayImages():void {
			
			addChild(_bitmapList[_currentPictureNumber]);
			
			this.stage.addEventListener(MouseEvent.CLICK, onClick);
			
			
		}
		
		private function onClick(e:MouseEvent):void {
			
			_currentPictureNumber++;
			if (_currentPictureNumber == _bitmapList.length) {
				_currentPictureNumber = 0;
			}
			removeChildAt(0);
			addChild(_bitmapList[_currentPictureNumber]);
		}
		
	}
}