package
{
	import com.Zambie.FlashBoard.Interfaces.IPlugin;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import libs.TimeOverlayBase;
	
	import org.osmf.events.TimeEvent;
	
	public class TimeOverlay extends Sprite implements IPlugin
	{
		
		private var _date:Date;
		private var _hours:int;
		private var _mins:int;
		private var _seconds:int;
		private var _timeDisplay:TimeOverlayBase;
		private var _dateFormat:String = "m/d/yy";
		public var type:String = "time";
		public var slideDuration:Number = 1;
		
		public function TimeOverlay()
		{
			
			trace(this.width);
			
		}
		
		public function get timeDisplay():TimeOverlayBase
		{
			return _timeDisplay;
		}

		
		
		public function init(xmlData:XML):void {
			
			
			
			_timeDisplay = new TimeOverlayBase();
			_timeDisplay.week_day.stop();
			_timeDisplay.meridiem.stop();
			addChild(_timeDisplay); 
			_timeDisplay.x = 100;
			_timeDisplay.y = _timeDisplay.height/2 + 50;
			var timer:Timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, updateTime);
			timer.start();
			
		}
		
		private function updateTime(e:TimerEvent):void {
			
			_date = new Date();
			var hours:Number = _date.getHours();
			var mins:Number = _date.getMinutes();
			
			if (hours > 12) {
				
				hours = hours - 12;
				
			}
			
			_timeDisplay.time_display.text = (hours < 10 ? "0" + hours : "" + hours) + ":" + (mins < 10 ? "0" + mins : "" + mins);
			
			
			updateDay();
			updateStamp();
			
		}
		
		private function updateStamp():void {
			
			switch(_dateFormat) {
				
				case "mmmm/dd/yyyy":
					_timeDisplay.date_stamp.text = convertMonth(_date.getMonth()) + " " + _date.getDate() + " ," + _date.getFullYear();
				break;
				
				case "mm/dd/yyyy":
					_timeDisplay.date_stamp.text = convertMonth(_date.getMonth()).slice(0, 3) + " " + _date.getDate() + " ," + _date.getFullYear();
				break;
				
				case "m/d/yy":
					_timeDisplay.date_stamp.text = _date.getMonth() + "/" + _date.getDate() + "/" + _date.getFullYear();
				break;
				
			}
			
			
		}
		
		private function updateDay():void {
			
			_timeDisplay.week_day.gotoAndStop(_date.getDay() + 1);
			
			if (_date.getHours() > 11) {
				
				_timeDisplay.meridiem.gotoAndStop(2);
				
			} else {
				
				_timeDisplay.meridiem.gotoAndStop(1);
				
			}
			
		}
		
		private function convertMonth(num:uint):String {
			var str:String;
			switch (num) {
				
				case 0:
					str = "January";
				break;
				
				case 1:
					str = "Febuary";
				break;
				
				case 2:
					str = "March";
				break;
				
				case 3:
					str = "April";
				break;
					
				case 4:
					str = "May";
				break;
				
				case 5:
					str = "June";
				break;
				
				case 6:
					str = "July";
				break;
				
				case 7:
					str = "August";
				break;
				
				case 8:
					str = "September";
				break;
				
				case 9:
					str = "October";
				break;
				
				case 10:
					str = "November";
				break;
				
				case 11:
					str = "December";
				break;
			}
			
			return str;
			
		}
		
		public function connect():void {
			
			trace("connected");
			
		}
		
		public function disconnect():void {
			
			trace("disconnected");
			
		}
		
		
		
		
		
	}
}