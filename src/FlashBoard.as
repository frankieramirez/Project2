package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	
	import libs.ConfigDialogBoxBase;
	
	public class FlashBoard extends Sprite
	{
		
		private var _setupMenu:ConfigDialogBoxBase;
		
		public function FlashBoard()
		{
			
			startUpUI();
			
		}
		
		private function startUpUI():void {
			
			
			
		}
		
		private function init():void {
			
			//This function sets up the application and all of it's dependancies in order to run. 
			
			
		}
		
		private function onFileSelect(e:Event):void {
			
			trace(e.currentTarget.nativePath);
			
		}
		
		private function loadXML():void {
			
			
			
		}
		
		private function onXMLLoad(e:Event):void {
			
			
			
		}
		
		private function updateSlides():void {
			
			
			
		}
		
		private function updatePlugins():void {
			
			
			
		}
		
		private function changeSlides():void {
			
			
			
		}
		
	}
}