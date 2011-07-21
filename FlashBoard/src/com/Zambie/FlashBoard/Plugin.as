package com.Zambie.FlashBoard
{
	
	import com.Zambie.FlashBoard.Interface.IPlugin;
	import com.jworkman.Effects.Fade;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	public class Plugin extends Sprite
	{
		
		private var _pluginXML:XML;
		private var _fader:Fade;
		private var _plugin:Sprite;
		private var _iplugin:*;
		private var _type:String;
		private var _slideDuration:Number;
		public static const SLIDE_DONE:String = "slide done";
		
		public function Plugin(xmlData:XML)
		{
			super();
			
			_fader = new Fade();
			
			_pluginXML = xmlData;
			
			/*this.graphics.beginFill(0xff0000);
			this.graphics.drawRect(0, 0, 200, 200);
			this.graphics.endFill();*/
			
			setupPlugin();
			
		}
		
		public function init(xmlData:XML):void {
			
			_iplugin.init(XML(xmlData));
			
		}
		
		public function get slideDuration():Number
		{
			return _slideDuration;
		}

		public function get type():String
		{
			return _type;
		}

		private function setupPlugin():void {
			
			//var file:File = File.desktopDirectory;
			var file:File = File.desktopDirectory.resolvePath(_pluginXML.filename);
			
			
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
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			
			
			
		}
		
		private function onComplete(e:Event):void {
			
			_plugin = e.currentTarget.content as Sprite;
			addChild(_plugin);
			
			_iplugin = _plugin;
			
			_iplugin.init(XML(_pluginXML.data));
			
			_type = _iplugin.type;
			_slideDuration = _iplugin.slideDuration;
			
			
			
		}
		
		public function connect():void {
			
			if (_type == "time") {
				
				
				
			} else if (_type == "video") {
				
				_plugin.addEventListener(Event.COMPLETE, onVideoDone);
				_fader.fadeIn(this, .08);
				_iplugin.connect();
				
			} else {
				
				_fader.fadeIn(this, .08);
				_iplugin.connect();
				
			}
			
			
		}
		
		private function onVideoDone(e:Event):void {
			
			var evt:Event = new Event(Plugin.SLIDE_DONE);
			dispatchEvent(evt);
			
		}
		
		public function disconnect():void {
			
			if (_type != "time") {
				
				_fader.fadeOut(this, .08);
				_iplugin.disconnect();
				
			}
			
			
		}
		
		
		
		
		
	}
}