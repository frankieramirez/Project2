package com.Zambie.FlashBoard.Interface
{
	public interface IPlugin
	{
		
		function init(xmlData:XML):void;
		
		function get duration():uint;
		
		function set duration(value:uint):void;
		
		function connect():void;
		
		function disconnect():void;
		
		function get fileName():String;
		
		function set fileName(str:String):void;
		
	}
}