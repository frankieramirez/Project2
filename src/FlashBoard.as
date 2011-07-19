package
{
	import com.Zambie.FlashBoard.UI.ConfigurationDBox;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	
	
	public class FlashBoard extends Sprite
	{
		
		private var _setupMenu:ConfigurationDBox;
		private var _xmlFilePath:String;
		private var _xmlReloadDuration:uint;
		
		public function FlashBoard()
		{
			
			startUpUI();
			
		}
		
		private function startUpUI():void {
			
			_setupMenu = new ConfigurationDBox();
			_setupMenu.addEventListener(ConfigurationDBox.CONFIGURATION_COMPLETE, onConfigurationComplete);
			this.addChild(_setupMenu);
			_setupMenu.x = this.stage.stageWidth/2;
			_setupMenu.y = this.stage.stageHeight/2;
			_setupMenu.initUI();
			
		}
		
		private function onConfigurationComplete(e:Event):void {
			
			
			
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