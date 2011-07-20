package com.zambi.ui
{
	import com.zambi.vo.InfoVO;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import libs.DetailViewBase;
	import libs.PanelBase;
	
	public class Panel extends PanelBase
	{		
		override public function Panel()
		{
			super();
		}
		
		public function update(data:Array):void
		{
			var i:int = 0;
			for each(var vo:InfoVO in data)
			{
				var _dv:DetailView = new DetailView(vo.username,vo.fullName);
				this.table.addChild(_dv);
				_dv.y = (_dv.height * i);
				//_dv.x = (_dv.width * i);				
				i++;
			}
			
		}

	}
}