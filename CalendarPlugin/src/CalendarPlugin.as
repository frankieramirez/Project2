package
{
	import com.events.CalendarServiceEvent;
	import com.services.CalendarService;
	import com.views.CalendarView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="1024", height="1024")]
	public class CalendarPlugin extends Sprite
	{
		private var _cv:CalendarView;
		private var _type:String;
		private var _slideDuration:Number;
		
		public function CalendarPlugin()
		{
		}
		
		public function init(xmlData:XML):void
		{
			_cv = new CalendarView();
			addChild(_cv);
			
			var url:String = "https://www.google.com/calendar/feeds/im1h8akabjmg57qabkp2vvcrb4%40group.calendar.google.com/public/basic";
			var cs:CalendarService = new CalendarService();
			cs.addEventListener(CalendarServiceEvent.CALEVENT_FOUND, onCalendarService);
			cs.load(String(xmlData.url));
		}
		
		private function onCalendarService(e:CalendarServiceEvent):void
		{
			_cv.calEvents = e.CalEvents;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function get slideDuration():Number
		{
			return _slideDuration;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function set slideDuration(value:Number):void
		{
			_slideDuration = value;
		}


	}
}