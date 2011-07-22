package
{
	import com.Zambie.FlashBoard.Interface.Plugin;
	import com.events.CalendarServiceEvent;
	import com.services.CalendarService;
	import com.views.CalendarView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class CalendarPlugin extends Plugin
	{
		private var _cv:CalendarView;
		
		public function CalendarPlugin()
		{
			this.fileName = "CalendarPlugin.swf";
		}

		override public function init(xmlData:XML):void
		{
			_cv = new CalendarView();
			addChild(_cv);
			//git hub is a big fail for this
			//someone strangle octacat, please!!!
			
			//var url:String = "https://www.google.com/calendar/feeds/im1h8akabjmg57qabkp2vvcrb4%40group.calendar.google.com/public/full?orderby=starttime";
			var cs:CalendarService = new CalendarService();
			cs.addEventListener(CalendarServiceEvent.CALEVENT_FOUND, onCalendarService);
			//cs.load(url);
			cs.load(String(xmlData.url));
		}
		
		private function onCalendarService(e:CalendarServiceEvent):void
		{
			_cv.calEvents = e.CalEvents;
		}

	}
}