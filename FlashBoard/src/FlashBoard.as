package
{
	import com.Zambie.FlashBoard.Interfaces.IPlugin;
	import com.Zambie.FlashBoard.UI.ConfigurationDBox;
	import com.Zambie.FlashBoard.Wrapper;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	
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
			fs.close();
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
			
			
			for each (var pluginNode:XML in _xmlData.plugins.plugin) {
				
				var file:File = new File(String(_xmlData.plugins.@directory) + "/" + pluginNode.filename);
				trace(file.nativePath);
				var fs:FileStream = new FileStream();
				fs.open(file, FileMode.READ);
				var ba:ByteArray = new ByteArray();
				
				fs.readBytes(ba,0,fs.bytesAvailable);
				
				var l:Loader = new Loader();
				addChild(l);
				l.load(new URLRequest("file://" + file.nativePath));
				
			}
			
		}
		
		private function onComplete(e:Event):void
		{
			trace('GOT IT!');
		}
		
		private function updatePlugins():void {
			
			
			
		}
		
		private function changeSlides():void {
			
			
			
		}
		
	}
}