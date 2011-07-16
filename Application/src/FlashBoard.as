package
{
	import com.zambie.FlashBoard.Services.Dashboard;
	
	import flash.display.Sprite;
	
	public class FlashBoard extends Sprite
	{
		
		private var _dashBoard:Dashboard;
		
		public function FlashBoard()
		{
			
			_dashBoard = new Dashboard(stage);
			this.addChild(_dashBoard);
			
		}
	}
}