package com.Zambie.FlashBoard.Interfaces
{
	public interface IPlugin
	{
		
		public function init(xmlData:XML):void;
		
		public function connect():void;
		
		public function disconnect():void;
		
	}
}