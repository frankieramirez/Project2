package com.Zambie.FlashBoard
{
	import flash.display.Sprite;
	
	public class Wrapper extends Sprite
	{
		public function Wrapper()
		{
			super();
			
			
			
		}
		
		public function makePlugin(url:String, variables:Array):void {
			
			trace(variables[0]);
			
		}
		
	}
}