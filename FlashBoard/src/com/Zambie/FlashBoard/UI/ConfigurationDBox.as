package com.Zambie.FlashBoard.UI
{
	import com.Zambie.FlashBoard.VO.RunTimeSettingsVO;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.SharedObject;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import libs.ConfigDialogBoxBase;
	
	public class ConfigurationDBox extends ConfigDialogBoxBase
	{
		
		public var filePath:String;
		public var reloadDuration:uint;
		private var _versionNumber:String;
		public static const CONFIGURATION_COMPLETE:String = "configuration complete";
		public static const SAVE_CONFIGURATION:String = "save config";
		
		
		public function ConfigurationDBox()
		{
			super();
			
			loadPrevSettings();
			
		}
		
		public function set versionNumber(value:String):void
		{
			_versionNumber = value;
			this.mc_version.tf_version.text = _versionNumber;
		}

		private function loadPrevSettings():void {
			
			var so:SharedObject = SharedObject.getLocal("startSettings");
			if (so.data.startupSettings) {
				
				filePath = so.data.startupSettings.filePath;
				
				if (so.data.startupSettings.fileMode == "local") {
					
					this.local_urltxt.text = filePath;
					
				} else {
					
					this.web_address.text = filePath;
					
				}
				
				
				
				if (so.data.startupSettings.startUp) {
					
					this.startup_checkbox.selected = true;
					
				}
				
				if (so.data.startupSettings.reloadDuration >= 1) {
					
					this.update_time_input.text = so.data.startupSettings.reloadDuration;
					
				}
				
				if (so.data.startupSettings.saveSettings == true) {
					
					this.save_btn.selected = true;
					
				} else {
					
					this.save_btn.selected = false;
					
				}
				
			} else {
				
				trace("no prev");
				
			}
			
		}
		
		
		
		public function initUI():void {
			
			
			this.file_btn.buttonMode = true;
			this.file_btn.addEventListener(MouseEvent.CLICK, onFileBrowse);
			
			
			
			this.start_btn.buttonMode = true;
			this.start_btn.addEventListener(MouseEvent.CLICK, onStart);
			
			this.update_time_input.restrict = "0-9";
			
			this.save_btn.addEventListener(MouseEvent.CLICK, onSaveClick);
			
			this.startup_checkbox.addEventListener(MouseEvent.CLICK, onStartupCheck);
			
		}
		
		private function onStartupCheck(e:MouseEvent):void {
			
			
			
		}
		
		
		
		private function onFileBrowse(e:MouseEvent):void {
			
			var file:File = new File();
			file.addEventListener(Event.SELECT, onFileSelect);
			//file.browse([new FileFilter("xmldata", "*.xml;")]);
			file.browseForOpen("Please select configuration XML", [new FileFilter("xmldata", "*.xml;")]);
			
		}
		
		private function onFileSelect(e:Event):void {
			
			filePath = String(e.currentTarget.nativePath);
			this.local_urltxt.text = filePath;
			trace("local file path : " + this.local_urltxt.text);
			this.web_address.text = "";
			
		}
		
		private function onStart(e:MouseEvent):void {
			
			this.onSaveClick(new MouseEvent(MouseEvent.CLICK));
			
			if (filePath != "") {
				
				reloadDuration = uint(this.update_time_input.text);
				
				dispatchEvent(new Event(ConfigurationDBox.CONFIGURATION_COMPLETE));
				
			} 
			
		}
		
		public function getFileMode():String {
			
			if (this.web_address.text == "" && this.local_urltxt.text != "") {
				
				return "local";
				
			} else if (this.web_address.text.length >= 6 && this.web_address.text.indexOf(".xml") != -1) {
				
				return "remote";
				
			} else {
				
				return "Sorry, invalid URL!";
				
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
		
		private function onSaveClick(e:MouseEvent):void {
			var so:SharedObject = SharedObject.getLocal("startSettings");
			if (this.save_btn.selected) {
				
				var settingsVo:RunTimeSettingsVO = new RunTimeSettingsVO();
				settingsVo.fileMode = this.getFileMode();
				settingsVo.reloadDuration = uint(this.update_time_input.text);
			
				if (this.getFileMode() == "local") {
				
					settingsVo.filePath = filePath;
					settingsVo.fileMode = "local";
				
				} else {
				
					settingsVo.filePath = this.web_address.text;
					settingsVo.fileMode = "remote";
				}
				
				if (this.save_btn.selected) {
					
					settingsVo.saveSettings = true;
					
				} else {
					
					settingsVo.saveSettings = false;
					
				}
			
				if (this.startup_checkbox.selected) {
					trace("startup application");
					settingsVo.startUp = true;
				
					NativeApplication.nativeApplication.startAtLogin = true;
				
				} else {
				
					settingsVo.startUp = false;
					NativeApplication.nativeApplication.startAtLogin = false;
				
				}
			
			
			
				
				so.clear();
				so.data.startupSettings = settingsVo;
				
			} else {
				
				so.clear();
				
			}
			
		}
		
	}
}