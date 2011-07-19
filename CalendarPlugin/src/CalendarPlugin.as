package
{
	import com.events.CalendarServiceEvent;
	import com.services.CalendarService;
	import com.views.CalendarView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class CalendarPlugin extends Sprite
	{
		private var _cv:CalendarView;
		
		public function CalendarPlugin()
		{
			init();
		}
		
		public function connect():void
		{
			
		}
		
		public function disconnect():void
		{
			
		}
		
		public function init():void
		{
			_cv = new CalendarView();
			addChild(_cv);
			
			var url:String = "https://www.google.com/calendar/feeds/im1h8akabjmg57qabkp2vvcrb4%40group.calendar.google.com/public/basic";
			var cs:CalendarService = new CalendarService();
			cs.addEventListener(CalendarServiceEvent.CALEVENT_FOUND, onCalendarService);
			cs.load(url);
		}
		
		private function onCalendarService(e:CalendarServiceEvent):void
		{
			_cv.calEvents = e.CalEvents;
		}
	}
}