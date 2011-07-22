package
{
	import com.Zambie.FlashBoard.Interface.Plugin;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import org.osmf.events.TimeEvent;
	import org.osmf.plugin.PluginClassResource;
	
	public class LiteWrapper extends Sprite
	{
		private var _xmlPrefs:XML;
		private var _timeRemaining:TextField;
		private var _timer:Timer;
		private var _plugin:Plugin;
		
		
		public function LiteWrapper()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
			// EDIT THIS TO PASS YOUR DATA IN
			_xmlPrefs = <data><url>http://hosted.ap.org/lineups/TOPHEADS-rss_2.0.xml?SITE=WYCHE&SECTION=HOME</url></data>;
			
			// PATH TO YOUR PLUGIN
			var file:File = File.desktopDirectory.resolvePath("swf/NewsPlugin.swf");
			
			_timeRemaining = new TextField();
			addChild(_timeRemaining);
			_timeRemaining.x = stage.stageWidth - 100;
			_timeRemaining.height = 30;
			
			_timer = new Timer(1000,7);
			_timer.addEventListener(TimerEvent.TIMER,updateTimeDisplay);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerDone);
			
			trace(file.nativePath);
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
		
		private function onPluginLoadComplete(evt:Event):void
		{
			_plugin = Plugin(evt.currentTarget.content);
			_plugin.init(_xmlPrefs);
			addChild(_plugin);
			_timer.start();
			
		}
		
		private function updateTimeDisplay(evt:TimerEvent):void
		{
			_timeRemaining.text = (_timer.repeatCount - _timer.currentCount) + "";
		}
		
		private function timerDone(evt:TimerEvent):void
		{
			removeChild(_plugin);
			_timer.reset();
			setTimeout(function():void{ addChild(_plugin); _timer.start();},3000);
		}
	}
}