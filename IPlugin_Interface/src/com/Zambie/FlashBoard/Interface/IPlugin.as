package com.Zambie.FlashBoard.Interface
{
	public interface IPlugin
	{
		
		function init(xmlData:XML, controller:*):void;
		
		function get type():String;
		
		function get slideDuration():Number;
		
	}
}