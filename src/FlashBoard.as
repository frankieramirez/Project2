package
{
	import com.Zambie.FlashBoard.UI.ConfigurationDBox;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	
	
	public class FlashBoard extends Sprite
	{
		private var _setupMenu:ConfigurationDBox;
		private var _xmlFilePath:String;
		private var _xmlReloadDuration:uint;
		private var _xmlData:XML;
		private var _defaultSlideTime:uint;
		
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
			
			_xmlFilePath = _setupMenu.filePath;
			_xmlReloadDuration = _setupMenu.reloadDuration;
			
			if (_xmlReloadDuration) {
				
				loadXML();
				
			} else {
				
				_setupMenu.throwError("Please enter duration.");
				
			}
			
		}
		
		private function init():void {
			
			//This function sets up the application and all of it's dependancies in order to run. 
			
			
		}
		
		private function onFileSelect(e:Event):void {
			
			trace(e.currentTarget.nativePath);
			
		}
		
		private function loadXML():void {
			
			var file:File = new File(_xmlFilePath);
			trace(_xmlFilePath);
			//file.load();
			
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.READ);
			var str:String = fs.readUTFBytes(fs.bytesAvailable);
			//file.addEventListener(Event.COMPLETE, onXMLLoad);
			_xmlData = XML(str);
			//trace(_xmlData);
			configureDashboard();
			
			
		}
		
		private function configureDashboard():void {
			
			_defaultSlideTime = _xmlData.configuration.slides.time;
			
			//Settup & configure plug-ins
			configurePlugins();
			
			//TODO: Settup & configure timers
			
			
			
		}
		
		private function updateSlides():void {
			
			
			
		}
		
		private function configurePlugins():void {
			
			for each(var plugin:XML in _xmlData.plugins.plugin) {
				
				
				
			}
			
		}
		
		private function updatePlugins():void {
			
			
			
		}
		
		private function changeSlides():void {
			
			
			
		}
		
	}
}