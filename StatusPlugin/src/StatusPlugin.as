package
{
	import com.zambi.ui.Panel;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	[SWF(width="1080",height="785")]
	public class StatusPlugin extends Sprite
	{
		private var _usernames:Array = [];
		private var _fullNames:Array = [];
		private var _statuses:Array = [];
		
		public function StatusPlugin()
		{
			var p:Panel = new Panel();
			this.addChild(p);
			p.detailView(_usernames,_fullNames);
		}
		
		public function initialize(xmlData:XML):void
		{
			for each(var user:XML in xmlData.userName)
			{	
				_usernames.push(user.text());
			}
			
			for each(var name:XML in xmlData.fullName)
			{
				_fullNames.push(name.text());
			}
		}
	}
}