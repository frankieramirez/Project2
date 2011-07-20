package
{
	
	import com.Zambie.FlashBoard.Plugin;
	import com.Zambie.FlashBoard.UI.ConfigurationDBox;
	import com.jworkman.Effects.Fade;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	
	
	public class FlashBoard extends Sprite
	{
		
		private var _setupMenu:ConfigurationDBox;
		private var _xmlFilePath:String;
		private var _xmlReloadDuration:uint;
		private var _xmlData:XML;
		private var _defaultSlideTime:uint;
		private var _slideTimer:Timer;
		private var _xmlTimer:Timer;
		private var _fader:Fade;
		private var _currentSlide:int = 0;
		
		private var _plugins:Array;
		private var _pluginXML:Array = [];
		private var _pluginConfigurations:Array = [];
		
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
				
			} 
			
		}
		
		private function loadXML():void {
			
			var file:File = new File(_xmlFilePath);
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.READ);
			var str:String = fs.readUTFBytes(fs.bytesAvailable);
			fs.close();
			_xmlData = XML(str);
			
			_defaultSlideTime = uint(_xmlData.configuration.slides.time);
			
			if (_defaultSlideTime) {
				
				loadPlugins();
				
			}
			
		}
		
		private function loadPlugins():void {
			
			_plugins = [];
			
			for each(var pluginNode:XML in _xmlData.plugins.plugin) {
				
				var plugin:Plugin = new Plugin(pluginNode);
				
				addChild(plugin);
				
				
				
				plugin.alpha = 0;
				
				_plugins.push(plugin);
				
			}
			
			startSlideShow();
			
		}
		
		private function startSlideShow():void {
			
			_plugins[0].alpha = 1;
			_plugins[_plugins.length - 1].alpha = 1;
			_plugins[_plugins.length - 1].scaleX = _plugins[_plugins.length - 1].scaleY = .5;
			
			//Start timers
			_slideTimer = new Timer(5 * 1000);
			_slideTimer.addEventListener(TimerEvent.TIMER, onChangeSlide);
			_slideTimer.start();
			
			
		}
		
		private function onChangeSlide(e:TimerEvent):void {
			
			_plugins[_currentSlide].disconnect();
			
			if (_currentSlide >= _plugins.length - 2) {
				
				_currentSlide = 0;
				
			} else {
				
				_currentSlide++;
				
			}
			
			_plugins[_currentSlide].connect();
			
		}
		
		
	}
}