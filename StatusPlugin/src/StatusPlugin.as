package
{
	import com.zambi.ui.Panel;
	import com.zambi.vo.InfoVO;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	[SWF(width="1080",height="785")]
	public class StatusPlugin extends Sprite
	{
		private var _p:Panel;
		
		public function StatusPlugin()
		{
			_p = new Panel();
			this.addChild(_p);
			//init();
		}
		
		public function init(xmlData:XML):void
		{
			//var usernames:Array = ["fjramirez249@me.com","oscar.cortez@me.com","sbernath@me.com"];
			//var fullNames:Array = ["Frankie Ramirez", "Oscar Cortez", "Sean Bernath"];
			var data:Array = [];
			
//			for each(var u:String in usernames)
//			{
//				_vo = new InfoVO();
//				_vo.username = u;
//				data.push(_vo);
//			}
			
			for each(var user:XML in xmlData.userName)
			{	
				var vo:InfoVO = new InfoVO();
				vo.fullName = user.@fullName;
				vo.username = user.@username;
				data.push(vo);
			}
			
			
			_p.update(data);
		}
	}
}