package com.Zambie.FlashBoard.UI
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import libs.ConfigDialogBoxBase;
	
	public class ConfigurationDBox extends ConfigDialogBoxBase
	{
		
		public var filePath:String;
		public var reloadDuration:uint;
		public static const CONFIGURATION_COMPLETE:String = "configuration complete";
		
		public function ConfigurationDBox()
		{
			super();
			
			
		}
		
		public function initUI():void {
			
			
			this.file_btn.buttonMode = true;
			this.file_btn.addEventListener(MouseEvent.CLICK, onFileBrowse);
			
			
			
			this.start_btn.buttonMode = true;
			this.start_btn.addEventListener(MouseEvent.CLICK, onStart);
			
			this.update_time_input.restrict = "0-9";
			
		}
		
		private function onFileBrowse(e:MouseEvent):void {
			
			var file:File = new File();
			file.addEventListener(Event.SELECT, onFileSelect);
			//file.browse([new FileFilter("xmldata", "*.xml;")]);
			file.browseForOpen("Please select configuration XML", [new FileFilter("xmldata", "*.xml;")]);
			
		}
		
		private function onFileSelect(e:Event):void {
			
			filePath = String(e.currentTarget.nativePath);
			
		}
		
		private function onStart(e:MouseEvent):void {
			if (filePath != "") {
				
				reloadDuration = uint(this.update_time_input.text);
				
				dispatchEvent(new Event(ConfigurationDBox.CONFIGURATION_COMPLETE));
				
			} 
			
		}
		
		public function throwError(str:String):void {
			
			var tf:TextField = new TextField();
			var tfFormat:TextFormat = new TextFormat();
			tfFormat.color = 0xff0000;
			tfFormat.size = 30;
			tf.text = str;
			this.addChild(tf);
			tf.x = this.width/2;
			tf.y = this.height/2;
			
		}
		
	}
}