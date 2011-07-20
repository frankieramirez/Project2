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
		
		public function CalendarPlugin()
		{
		}
		
		public function init(xml:XML):void
		{
			_cv = new CalendarView();
			addChild(_cv);
			
			var url:String = XML(xml.data.url);
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