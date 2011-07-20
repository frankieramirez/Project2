package com.ramirez
{
	public interface IPlugin
	{
		function init(xmlData:XML):void;
		function get pluginName():String;
	}
}