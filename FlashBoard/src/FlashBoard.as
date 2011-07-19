package
{
	import com.Zambie.FlashBoard.Interfaces.IPlugin;
	import com.Zambie.FlashBoard.UI.ConfigurationDBox;
	import com.Zambie.FlashBoard.Wrapper;
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
		
		private var _plugins:Array = [];
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
				
				
				startSlides();
				
			} else {
				
				_setupMenu.throwError("Please enter duration.");
				
			}
			
			
			
		}
		
		private function init():void {
			
			//This function sets up the application and all of it's dependancies in order to run. 
			
			
		}
		
		private function onFileSelect(e:Event):void {
			
			//trace(e.currentTarget.nativePath);
			
		}
		
		private function loadXML():void {
			
			var file:File = new File(_xmlFilePath);
			//trace(_xmlFilePath);
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
			
			
			
			
			
		}
		
		private function startSlides():void {
			//TODO: Settup & configure timers
			
			_fader = new Fade();
			_fader.fadeOut(_setupMenu, .08);
			
			_slideTimer = new Timer(5000);
			_slideTimer.start();
			
			_slideTimer.addEventListener(TimerEvent.TIMER, onSlideChange);
		}
		
		private function onSlideChange(e:TimerEvent):void {
			_fader = new Fade();
			
			_fader.fadeOut(_plugins[_currentSlide], .08);
			
			var tmpFade:Fade = new Fade();
			
			_currentSlide++;
			
			if (_currentSlide >= _plugins.length) {
				
				_currentSlide = 0;
				
				tmpFade.fadeIn(_plugins[_currentSlide] as Sprite, .08);
				
			} else {
				
				tmpFade.fadeIn(_plugins[_currentSlide] as Sprite, .08);
				
			}
			
			
		}
		
		private function updateSlides():void {
			
			
			
		}
		
		private function configurePlugins():void {
			
			
			for each (var pluginNode:XML in _xmlData.plugins.plugin) {
				
				//var file:File = File.desktopDirectory;
				var file:File = File.desktopDirectory.resolvePath(pluginNode.filename);
			
				
				//file.resolvePath(pluginNode.filename);
				
				
				var fs:FileStream = new FileStream();
				fs.open(file, FileMode.READ);
				var ba:ByteArray = new ByteArray();
				
				fs.readBytes(ba);
				fs.close();
				
				var loaderContext: LoaderContext = new LoaderContext();
				loaderContext.allowLoadBytesCodeExecution = true;
				
				var l:Loader = new Loader();
				l.loadBytes(ba,loaderContext);
				l.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
				
				_pluginXML.push(pluginNode.data);
				_pluginConfigurations.push(pluginNode);
				
				/*var l:Loader = new Loader();
				addChild(l);
				l.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
				l.load(new URLRequest("file://" + file.nativePath));*/
				
			}
			
			
			
		}
		
		private function onComplete(e:Event):void
		{
			
			var plugin:Sprite = e.currentTarget.content as Sprite;
			_plugins.push(plugin);
			addChild(plugin);
			plugin.alpha = 0;
			
			initPlugins();
		}
		
		private function initPlugins():void {
			var i:int = 0;
			for each(var plugin:IPlugin in _plugins) {
				
				plugin.init(XML(_pluginXML[i]));
				//trace(_pluginConfigurations[i]);
				i++;
				
			}
			
			
		}
		
		
	}
}