package
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	
	import com.Zambie.FlashBoard.Interface.IPlugin;
	import com.Zambie.FlashBoard.Interface.Plugin;
	import com.Zambie.FlashBoard.UI.ConfigurationDBox;
	import com.Zambie.FlashBoard.UI.TimeOverlay;
	import com.jworkman.Effects.Fade;
	
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	
	import mx.core.Window;
	
	[SWF(width="800", height="800", backgroundColor="0x000000")]
	
	public class FlashBoard extends Sprite
	{
		
		//XML related variables
		private var _xmlFilePath:String;
		private var _xmlReloadDuration:uint;
		private var _xmlData:XML;
		private var _xmlTimer:Timer;
		private var _xmlFileMode:String;
		private var _theme:XML;
		
		//Setup/Configuration window
		private var _setupMenu:ConfigurationDBox;
		private var _versionStr:String;
		
		//Slide related variables
		private var _defaultSlideTime:uint;
		private var _slideTimer:Timer;
		private var _currentSlide:int = 0;
		private var _slideStarted:Boolean = false;
		
		
		//Plugin related variables
		private var _pluginsDir:String;
		private var _plugins:Array = [];
		private var _pluginXML:Array = [];
		private var _pluginConfigurations:Array = [];
		private var _pluginList:Object;
		private var _numPlugins:int = 0;
		private var _currentLoad:int = 0;
		
		
		//Fade & Effects settings
		private var _fader:Fade;
		
		//Window & Stage related vars
		private var _background:Bitmap;
		private var _backgroundAdded:Boolean = false;
		private var _registrationX:Number;
		private var _registrationY:Number;
		private var _pluginWidth:Number;
		private var _pluginHeight:Number;
		private var _aspectRatio:Number;
		private var _aspectRatioStr:String;
		private const PLUGIN_RATIO_X:Number = .9;
		private const PLUGIN_RATIO_Y:Number = .85;
		
		//Time Overlay related vars
		private var _timeOverlay:TimeOverlay;
		private var _timeOverlayAdded:Boolean = false;
		private var _alignX:String = "right";
		private var _alignY:String = "top";
		
		public static const PLUGIN_LOADED:String = "plugin loaded";
		
		
		public function FlashBoard()
		{
			
			
			
			
			initUpdates();
			
			
			
			
			
			
			startUpUI();
			
			
			
			
			
			
			
		}
		
		private function getScreenSize():void {
			
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			this.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
			this.stage.nativeWindow.width = Capabilities.screenResolutionX;
			this.stage.nativeWindow.height = Capabilities.screenResolutionY;
			
			this.stage.stageWidth = Capabilities.screenResolutionX;
			this.stage.stageHeight = Capabilities.screenResolutionY;
			
			
			
			_aspectRatio = this.stage.nativeWindow.width / this.stage.nativeWindow.height;
			
			if (_aspectRatio <= 1.5) {
				
				_aspectRatioStr = "4x3";
				
			} else {
				
				_aspectRatioStr = "16x9";
				
			}
			
			
			
		}
		
		private function startUpUI():void {
			_pluginList = {};
			
		
			
			this.stage.align = StageAlign.TOP_LEFT;
			
			
			_fader = new Fade;
			_setupMenu = new ConfigurationDBox();
			_setupMenu.addEventListener(ConfigurationDBox.CONFIGURATION_COMPLETE, onConfigurationComplete);
			this.addChild(_setupMenu);
			_setupMenu.x = this.stage.stageWidth/2 - _setupMenu.width/2;
			
			
			_setupMenu.y = this.stage.stageHeight/2 - _setupMenu.height/2;
			
			_setupMenu.initUI();
			//_setupMenu.versionNumber = _versionStr;
			
		}
		
		
		
		private function onConfigurationComplete(e:Event):void {
			
			
			getScreenSize();
			
			
			_xmlFileMode = _setupMenu.getFileMode();
			
			
			
			if (_xmlFileMode == "local" && _setupMenu.filePath) {
				
				_xmlFilePath = _setupMenu.filePath;
				
				loadLocalXML();
				
			} else if (_xmlFileMode == "remote") {
				
				_xmlFilePath = _setupMenu.web_address.text;
				loadRemoteXML();
				
			} else {
				
				_setupMenu.throwError(_xmlFileMode);
				
			}
			
			
			
			this.removeChild(_setupMenu);
			
		}
		
		private function loadRemoteXML():void {
			
			var ul:URLLoader = new URLLoader();
			var ur:URLRequest = new URLRequest("http://" + _xmlFilePath);
			ul.addEventListener(Event.COMPLETE, onRemoteXMLLoaded);
			ul.load(ur);
			
		}
		
		private function onRemoteXMLLoaded(e:Event):void {
			
			_xmlData = XML(e.currentTarget.data);
			
			configureXMLSettings();
			
		}
		
		private function loadLocalXML():void {
			
			var file:File = new File(_xmlFilePath);
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.READ);
			var str:String = fs.readUTFBytes(fs.bytesAvailable);
			fs.close();
			_xmlData = XML(str);
			
			configureXMLSettings();
			
		}
		
		private function configureXMLSettings():void {
			
			_theme = XML(_xmlData.configuration.theme);
			
			if (_aspectRatioStr == "16x9") {
				
				_registrationX = Number(_theme.background[0].registrationX);
				_registrationY = Number(_theme.background[0].registrationY);
				_pluginWidth = Number(_theme.background[0].width);
				_pluginHeight = Number(_theme.background[0].height);
				
			} else {
				
				_registrationX = Number(_theme.background[1].registrationX);
				_registrationY = Number(_theme.background[1].registrationY);
				_pluginWidth = Number(_theme.background[1].width);
				_pluginHeight = Number(_theme.background[1].height);
				
			}
			
			
			
			
			
			for each(var i:XML in _xmlData.plugins.plugin) {
				
				_numPlugins++;
				
			}
			
			loadBackground();
			
			_defaultSlideTime = uint(_xmlData.configuration.slides.time);
			
			_pluginsDir = String(_xmlData.plugins.@directory);
			
			
				
				
				
			if (_defaultSlideTime) {
				
				loadPlugin(_currentLoad);
				
			}
			
		}
		
		
		
		
		private function loadBackground():void {
			
			
			
			if (String(_xmlData.configuration.theme.@active) == "on") {
				
				var ld:Loader = new Loader();
				var ur:URLRequest = new URLRequest();
				if (_aspectRatioStr == "16x9") {
					
					ur.url = String(_xmlData.configuration.theme.background[0].url);
					
				} else {
					
					ur.url = String(_xmlData.configuration.theme.background[1].url);
					
				}
				
				ld.contentLoaderInfo.addEventListener(Event.COMPLETE, onBackgroundLoad);
				ld.load(ur);
				
			}
			
			
		}
		
		
		private function onBackgroundLoad(e:Event):void {
			
			_background = e.currentTarget.content as Bitmap;
			
			this.addChildAt(_background, 0);
			_background.x = _background.y = 0;
			
			var fd:Fade = new Fade();
			fd.fadeInBitmap(_background, .025, Number(_xmlData.configuration.theme.background.opacity) / 100);
			
			_background.smoothing = true;
			
			_backgroundAdded = true;
			
			
			_background.width = stage.stageWidth;
			_background.height = stage.stageHeight;
			
		}
		
		
		
		private function loadPlugin(loadNum:int):void {
			
			var file:File = new File(String(_pluginsDir + _xmlData.plugins.plugin[loadNum].filename));
			
			
			_pluginList[_xmlData.plugins.plugin[loadNum].filename] = _xmlData.plugins.plugin[loadNum];
			
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.READ);
			var ba:ByteArray = new ByteArray();
			
			fs.readBytes(ba);
			fs.close();
			
			var loaderContext:LoaderContext = new LoaderContext();
			loaderContext.allowLoadBytesCodeExecution = true;
			
			var l:Loader = new Loader();
			l.loadBytes(ba,loaderContext);
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, onPluginLoadComplete);
			
			
		}
		
		private function onPluginLoadComplete(e:Event):void {
			var p:Plugin = e.currentTarget.content as Plugin;
			
			
			
			var pXML:XML = XML(_pluginList[p.fileName].data);
			
			
			
			
			
			
			
			p.init(pXML);
			
			
			
			if (!p.duration) {
				
				p.duration = _defaultSlideTime;
				
			} 
			
			trace("this plugin duration is : " + p.duration);
			
			
			
			p.x = _registrationX;
			p.y = _registrationY;
			
			
			
			_plugins.push(p);
			
			
			onPluginLoaded();
			
			
		}
		
		private function onPluginLoaded():void {
			
			if (!_slideStarted) {
				
				_slideStarted = true;
				startSlideShow();
				
			}
			
			if (_currentLoad < _numPlugins - 1) {
				
				_currentLoad++;
				loadPlugin(_currentLoad);
				
			}
			
			
		}
		
		private function startSlideShow():void {
			
			
				
			_fader.addEventListener(Fade.FADE_COMPLETE, onFadeComplete);
			
			_slideTimer = new Timer(3000);
			
			_slideTimer.addEventListener(TimerEvent.TIMER, onSlideDone);
			
			_plugins[_currentSlide].alpha = 1;
			
			if (_backgroundAdded && _timeOverlayAdded) {
				
				this.addChildAt(_plugins[_currentSlide], 1);
				
			} else if (_backgroundAdded && !_timeOverlayAdded) {
				
				this.addChild(_plugins[_currentSlide]);
				
			} else if (!_backgroundAdded && _timeOverlayAdded) {
				
				this.addChildAt(_plugins[_currentSlide], 0);
				
			} else {
				
				this.addChild(_plugins[_currentSlide]);
				
			}
			
			_plugins[_currentSlide].x = _registrationX;
			_plugins[_currentSlide].y = _registrationY;
			
			if (String(_xmlData.configuration.clock.@active) == "on") {
				
				initTimeOverlay(_xmlData);
				
			}
			
			
			
			
			
			
			
			_slideTimer.start();
			
			
			
		}
		
		private function onFadeComplete(e:Event):void {
			
			
				
			this.removeChild(_plugins[_currentSlide]);
			_plugins[_currentSlide].alpha = 1;
				
			
			
			
			
			if (_currentSlide >= _plugins.length - 1) {
				
				_currentSlide = 0;
				
			} else {
				
				_currentSlide++;
				
			}
			
			
			
			
			if (_backgroundAdded && _timeOverlayAdded) {
				
				this.addChildAt(_plugins[_currentSlide], 1);
				
			} else if (_backgroundAdded && !_timeOverlayAdded) {
				
				this.addChild(_plugins[_currentSlide]);
				
			} else if (!_backgroundAdded && _timeOverlayAdded) {
				
				this.addChildAt(_plugins[_currentSlide], 0);
				
			} else {
				
				this.addChild(_plugins[_currentSlide]);
				
			}
			
			_plugins[_currentSlide].x = _registrationX;
			_plugins[_currentSlide].y = _registrationY;
			
			
			if (_aspectRatioStr == "16x9") {
				var p:Number = stage.stageWidth/1600;
				var p2:Number = stage.stageHeight/900;
				_plugins[_currentSlide].width = p * _pluginWidth;
				_plugins[_currentSlide].height = p2 * _pluginHeight;
			} else if (_aspectRatioStr == "4x3") {
				var p3:Number = stage.stageWidth/1200;
				var p4:Number = stage.stageHeight/900;
				_plugins[_currentSlide].width = p3 * _pluginWidth;
				_plugins[_currentSlide].height = p4 * _pluginHeight;
			}
			
			
			
			
			_slideTimer.delay = Number(_plugins[_currentSlide].duration * 1000);
			
			
			
			_slideTimer.start();
			
		}
		
		private function onSlideDone(e:TimerEvent):void {
			
			_slideTimer.reset();
			
			
			_fader.fadeOut(_plugins[_currentSlide], .08);
			
			
		}
		
		private function initTimeOverlay(xmlData:XML):void {
			
			_timeOverlay = new TimeOverlay();
			
			_timeOverlay.init(xmlData);
			
			this.addChild(_timeOverlay);
			_timeOverlayAdded = true;
			
			_timeOverlay.alpha = Number(xmlData.configuration.clock.opacity / 100);
			
			_alignX = String(xmlData.configuration.clock.registrationX);
			
			_alignY = String(xmlData.configuration.clock.registrationY);
			
			_timeOverlay.x = Number(xmlData.configuration.clock.registrationX);
			
			_timeOverlay.y = Number(xmlData.configuration.clock.registrationY);
			
			
			
			
			
		}
		
		private function initUpdates():void {
			
			var ul:URLLoader = new URLLoader();
			var ur:URLRequest = new URLRequest("http://jworkman.no-ip.org/flashboard/updates/latestVersion.xml");
			ul.addEventListener(Event.COMPLETE, onUpdateXMLLoad);
			ul.load(ur);
			
		}
		
		private function onUpdateXMLLoad(e:Event):void {
			trace("yup");
			var xmlData:XML = XML(e.currentTarget.data);
			var na:NativeApplication = NativeApplication.nativeApplication;
			var ns:Namespace = new Namespace(null,"http://ns.adobe.com/air/application/1.5.3");
			_versionStr = String("Version " + na.applicationDescriptor.ns::version);
			
			if (Number(xmlData.latestVersion) > Number(na.applicationDescriptor.ns::version)) {
				
				var textFormat:TextFormat = new TextFormat("Helvetica", 20, 0x0080ec);
				
				_setupMenu.mc_version.tf_version.defaultTextFormat = textFormat;
				
				_setupMenu.mc_version.tf_version.text = "New updates Available!";
				_setupMenu.mc_version.mouseChildren = false;
				_setupMenu.mc_version.buttonMode = true;
				
				_setupMenu.mc_version.addEventListener(MouseEvent.CLICK, startUpdateUI);
				
			} else {
				
				_setupMenu.versionNumber = _versionStr;
				
			}
			
			
			
		}
		
		private function startUpdateUI(e:MouseEvent):void {
			
			
			var updater:ApplicationUpdaterUI = new ApplicationUpdaterUI();
			updater.delay = 1; 
			updater.updateURL = "http://jworkman.no-ip.org/flashboard/updates/update.xml";
			updater.initialize();
			updater.addEventListener(UpdateEvent.INITIALIZED, onUpdateStart);
			
		}
		
		private function onUpdateStart(e:UpdateEvent):void {
			
			e.currentTarget.checkNow();
			
		}
		
		
	}
}