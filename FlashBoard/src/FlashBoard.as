package
{
	import com.Zambie.FlashBoard.Interface.IPlugin;
	import com.Zambie.FlashBoard.Interface.Plugin;
	import com.Zambie.FlashBoard.UI.ConfigurationDBox;
	import com.jworkman.Effects.Fade;
	
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
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	
	import mx.core.Window;
	
	[SWF(backgroundColor="0x000000")]
	
	public class FlashBoard extends Sprite
	{
		
		//XML related variables
		private var _xmlFilePath:String;
		private var _xmlReloadDuration:uint;
		private var _xmlData:XML;
		private var _xmlTimer:Timer;
		private var _xmlFileMode:String;
		
		//Setup/Configuration window
		private var _setupMenu:ConfigurationDBox;
		
		//Slide related variables
		private var _defaultSlideTime:uint;
		private var _slideTimer:Timer;
		private var _currentSlide:int = 0;
		private var _slideStarted:Boolean = false;
		private var _timeOverlay:DisplayObject;
		
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
		private var _transitions:Array;
		
		//Window & Stage related vars
		private var _background:Bitmap;
		private var _regX:Number = 75;
		private var _regY:Number = 50;
		private var _pluginWidth:Number;
		private var _pluginHeight:Number;
		private var _aspectRatio:Number;
		private var _aspectRatioStr:String;
		private const PLUGIN_RATIO_X:Number = .9;
		private const PLUGIN_RATIO_Y:Number = .85;
		
		public static const PLUGIN_LOADED:String = "plugin loaded";
		
		
		public function FlashBoard()
		{
			
			getScreenSize();
			
			startUpUI();
			
		}
		
		private function getScreenSize():void {
			
			/*var nativeX:Number = Capabilities.screenResolutionX - stage.nativeWindow.width;
			var nativeWindowOptions:NativeWindowInitOptions = new NativeWindowInitOptions();
			nativeWindowOptions.systemChrome = NativeWindowSystemChrome.NONE;
			nativeWindowOptions.maximizable = true;
			var tmpWindow:NativeWindow = new NativeWindow(nativeWindowOptions);
			tmpWindow.maximize();
			tmpWindow.height = Capabilities.screenResolutionY;
			tmpWindow.width = Capabilities.screenResolutionX;
			trace("Native window size : " + stage.nativeWindow.width);*/
			
			this.stage.nativeWindow.width = Capabilities.screenResolutionX;
			this.stage.nativeWindow.height = Capabilities.screenResolutionY;
			
			this.stage.stageWidth = Capabilities.screenResolutionX;
			this.stage.stageHeight = Capabilities.screenResolutionY;
			
			trace("Native Window : " + this.stage.nativeWindow.width + " X " + this.stage.nativeWindow.height);
			trace("Screen : " + this.stage.stageWidth + " X " + this.stage.stageHeight);
			
			_aspectRatio = this.stage.nativeWindow.width / this.stage.nativeWindow.height;
			
			if (_aspectRatio <= 1.5) {
				
				_aspectRatioStr = "4x3";
				
			} else {
				
				_aspectRatioStr = "16x9";
				
			}
			
			trace("Aspect Ratio : " + _aspectRatioStr);
			
		}
		
		private function startUpUI():void {
			_pluginList = {};
			
		
			
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
			
			_fader = new Fade;
			_setupMenu = new ConfigurationDBox();
			_setupMenu.addEventListener(ConfigurationDBox.CONFIGURATION_COMPLETE, onConfigurationComplete);
			this.addChild(_setupMenu);
			_setupMenu.x = this.stage.stageWidth/2 - _setupMenu.width;
			_setupMenu.y = this.stage.stageHeight/2 - _setupMenu.height/2;
			trace(_setupMenu.height);
			_setupMenu.initUI();
			
		}
		
		
		
		private function onConfigurationComplete(e:Event):void {
			
			/*_xmlFilePath = _setupMenu.filePath;
			_xmlReloadDuration = _setupMenu.reloadDuration;
			
			
			
			if (_xmlReloadDuration) {
				
				loadXML();
				
			} */
			
			
			//This section is for rather loading a local .xml, or remote
			_xmlFileMode = _setupMenu.getFileMode();
			
			trace("XMLFileMode = " , _xmlFileMode);
			
			if (_xmlFileMode == "local" && _setupMenu.filePath) {
				
				_xmlFilePath = _setupMenu.filePath;
				
				loadXML();
				
			} else if (_xmlFileMode == "remote") {
				
				_xmlFilePath = _setupMenu.web_address.text;
				loadRemoteXML();
				
			} else {
				
				_setupMenu.throwError(_xmlFileMode);
				
			}
			
			if (_setupMenu.startup_checkbox.selected) {
				
				//TODO: Make application launch at startup
				
			} else {
				
				//TOTO: Disable application launch at startup if exists
				
			}
			
			this.removeChild(_setupMenu);
			
		}
		
		private function loadRemoteXML():void {
			
			var ul:URLLoader = new URLLoader();
			var ur:URLRequest = new URLRequest("http://" + _xmlFilePath);
			ul.addEventListener(Event.COMPLETE, onXMLLoaded);
			ul.load(ur);
			
		}
		
		private function onXMLLoaded(e:Event):void {
			
			_xmlData = XML(e.currentTarget.data);
			//loadBackground();
			_defaultSlideTime = uint(_xmlData.configuration.slides.time);
			_pluginsDir = String(_xmlData.plugins.@directory);
			_transitions = [];
			
			
			
			_transitions["fadeIn"] = uint(_xmlData.configuration.slides.transitions.@fadeIn);
			_transitions["fadeOut"] = uint(_xmlData.configuration.slides.transitions.@fadeOut);
			
			
			if (_defaultSlideTime) {
				
				loadPlugins();
				
			}
			
		}
		
		private function loadXML():void {
			
			var file:File = new File(_xmlFilePath);
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.READ);
			var str:String = fs.readUTFBytes(fs.bytesAvailable);
			fs.close();
			_xmlData = XML(str);
			
			for each(var i:XML in _xmlData.plugins.plugin) {
				
				_numPlugins++;
				
			}
			trace(_numPlugins  + " plugins found in the config file");
			
			loadBackground();
			
			_defaultSlideTime = uint(_xmlData.configuration.slides.time);
			
			_pluginsDir = String(_xmlData.plugins.@directory);
			_transitions = [];
			
			
			
			_transitions["fadeIn"] = uint(_xmlData.configuration.slides.transitions.@fadeIn);
			_transitions["fadeOut"] = uint(_xmlData.configuration.slides.transitions.@fadeOut);
			
			
			if (_defaultSlideTime) {
				
				loadPlugins();
				
			}
			
		}
		
		
		
		
		private function loadBackground():void {
			
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
		
		
		private function onBackgroundLoad(e:Event):void {
			
			_background = e.currentTarget.content as Bitmap;
			
			this.addChildAt(_background, 0);
			_background.x = _background.y = 0;
			
			var fd:Fade = new Fade();
			fd.fadeInBitmap(_background, .025, Number(_xmlData.configuration.theme.background.opacity) / 100);
			
			_background.smoothing = true;
			
			
			_background.width = stage.stageWidth;
			_background.height = stage.stageHeight;
			
		}
		
		private function loadPlugins():void {
			
			
			loadPlugin(_currentLoad);
			
			
			/*for each(var pluginNode:XML in _xmlData.plugins.plugin) {
				//var file:File = File.desktopDirectory;
				var file:File = File.desktopDirectory.resolvePath(pluginNode.filename);
			
				pluginList[pluginNode.filename] = pluginNode;
				//file.resolvePath(pluginNode.filename);
				
			
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
				_numPlugins++;
			}
			
			
			
			this.addEventListener(Event.ENTER_FRAME, checkLoad);
			
			*/
			
		}
		
		private function loadPlugin(loadNum:int):void {
			//trace("LoadPlugin #" , loadNum);
			//trace(_xmlData.plugins.plugin[loadNum].filepath);
			//var file:File = File.desktopDirectory.resolvePath(
			var file:File = new File(_xmlData.plugins.plugin[loadNum].filepath);
			//file.resolvePath(_xmlData.plugins.plugin[loadNum].filepath);
			
			_pluginList[_xmlData.plugins.plugin[loadNum].filename] = _xmlData.plugins.plugin[loadNum];
			//file.resolvePath(pluginNode.filename);
			
			//trace("FILE PATH:",file.nativePath);
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
			
			//p.duration = uint(_defaultSlideTime);
			
			
			var pXML:XML = XML(_pluginList[p.fileName].data);
			
			
			
			if (!p.duration) {
				
				p.duration = _defaultSlideTime;
				
			}
			
			trace("plugin duration of " + p.duration + " While default duration = " + _defaultSlideTime);
			
			p.init(pXML);
			
			
			
			
			
			p.x = _regX;
			p.y = _regY;
			
			//trace("Width of Plugin" + p.width);
			
			_plugins.push(p);
			
			
			onPluginLoaded();
			
			//addChild(p);
			
			//trace("NumChildren : " , this.numChildren);
		}
		
		private function onPluginLoaded():void {
			
			if (!_slideStarted) {
				
				_slideStarted = true;
				startSlideShow();
				
			}
			//trace("1");
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
			
			/*if (this.contains(_timeOverlay) && this.contains(_background)) {
				
				this.addChildAt(_plugins[_currentSlide], 1);
				
			} else if(this.contains(_background)) {
				
				this.addChildAt(_plugins[_currentSlide], 1);
				
			} else if (this.contains(_timeOverlay)) {
				
				this.addChildAt(_plugins[_currentSlide], 0);
				
			} else {
				
				this.addChild(_plugins[_currentSlide]);
				
			}*/
			
			this.addChild(_plugins[_currentSlide]);
			
			
			_plugins[_currentSlide].width = PLUGIN_RATIO_X * this.stage.stageWidth;
			_plugins[_currentSlide].height = PLUGIN_RATIO_Y * this.stage.stageHeight;
			
			
			
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
			
			
			this.addChild(_plugins[_currentSlide]);
			_plugins[_currentSlide].width = PLUGIN_RATIO_X * this.stage.stageWidth;
			_plugins[_currentSlide].height = PLUGIN_RATIO_Y * this.stage.stageHeight;
			
			//trace("Slide #" + _currentSlide + " has a duration of " + _plugins[_currentSlide].duration);
			
			_slideTimer.delay = Number(_plugins[_currentSlide].duration * 1000);
			_slideTimer.start();
			
		}
		
		private function onSlideDone(e:TimerEvent):void {
			//trace("slide Done");
			_slideTimer.reset();
			
			
			_fader.fadeOut(_plugins[_currentSlide], .08);
			
			
		}
		
		/*
		private function checkLoad(e:Event):void {
			
			if (_plugins.length >= _numPlugins) {
				trace(_plugins.length);
				this.removeEventListener(Event.ENTER_FRAME, checkLoad);
				initSlideShow();
			} 
			
		}*/
		
		/*
		
		private function onPluginLoadComplete(e:Event):void {
			
			var plugin:Plugin = e.currentTarget.content as Plugin;
			
			_plugins.push(plugin);
			
			
			
			var pluginXML:XML = XML(pluginList[plugin.fileName].data);
			
			//trace(plugin.alpha);
			
			plugin.init(pluginXML);
			
			if (String(XML(pluginList[plugin.fileName].duration)) == "") {
				
				plugin.duration = _defaultSlideTime;
				
			} else {
				
				plugin.duration = uint(XML(pluginList[plugin.fileName].duration));
				
			}
			
			if (String(pluginList[plugin.fileName].transition.@fadeIn) != "" && String(pluginList[plugin.fileName].transition.@fadeOut) != "") {
				
				var tmpTrans:Array = [];
				tmpTrans['fadeIn'] = uint(pluginList[plugin.fileName].transition.@fadeIn);
				tmpTrans['fadeOut'] = uint(pluginList[plugin.fileName].transition.@fadeOut);
				
				trace(tmpTrans);
				
				plugin.transitions = tmpTrans;
				
			} else {
				
				plugin.transitions = _transitions;
				
			}
			
			
			
			addChild(plugin);
			//plugin.x = this.stage.stageWidth/2;
			//plugin.y = this.stage.stageHeight/2;
			
			
			
			
		}*/
		
		/*
		
		private function initSlideShow():void {
			
			
			for each(var plugin:Plugin in _plugins) {
				
				plugin.addEventListener(Plugin.TIME_DONE, onSlideDone);
				
			}
			
			_plugins[_currentSlide].alpha = 1;
			_plugins[_currentSlide].connect();
			
			
			
		}*/
		
		/*
		
		private function onSlideDone(e:Event):void {
			
			_plugins[_currentSlide].disconnect();
			
			
			if (_currentSlide >= _plugins.length - 1) {
				
				_currentSlide = 0;
				
			} else {
				
				_currentSlide++;
				
			}
			
			_plugins[_currentSlide].connect();
			
		}*/
		
		
		
		
		
		
		
		
	}
}