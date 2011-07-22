package com.views
{
	import flash.display.Sprite;
	
	import libs.CalendarViewBase;
	
	public class CalendarView extends CalendarViewBase
	{
		private var _calEvents:Array = [];
		private var _displayedItems:Array = [];
		//if(stage.stageWidth/stage.stageHeight<1.5)
		//original
		//else 16x9
		public function CalendarView()
		{
			super();

		}

		public function set calEvents(value:Array):void
		{
			_calEvents = value;
			
			var todayNum:Date = new Date();
			var relDays:Array = [];
			
			if(stage.stageWidth/stage.stageHeight<1.5)
			{
				for(var z:int; z < _calEvents.length; z++)
				{
					if(_calEvents[z].day >= todayNum.date && _calEvents[z].month >= todayNum.month)
					{
						relDays.push(_calEvents[z]);
					}
				}
				
				//trace(relDays[relDays.length-1].title);
				var calviewbase1:CalendarViewDetailBaseFirst = new CalendarViewDetailBaseFirst(relDays[relDays.length-1]);
				calviewbase1.y = 75;
				
				
				var downNum:int = relDays.length - 1;
				for(var d:int; d < 3; d++)
				{
					downNum--;
					var cvd:CalendarViewDetail = new CalendarViewDetail(relDays[downNum]);
					cvd.y = (cvd.height*d) + (calviewbase1.y + calviewbase1.height);
					addChild(cvd);
				}
				addChild(calviewbase1);
				
				var cTitle:String;
				var startUpcomingNum:int = downNum;
				var yPos:int;
				for(var j:int; j < downNum; j++)
				{
					downNum--;
					cTitle = relDays[downNum].dayName;
					if(startUpcomingNum == downNum+1)
					{
						var cvt:CalendarViewUpcomingTitle = new CalendarViewUpcomingTitle();
						cvt.title = relDays[downNum];
						//var dt4t:Date = new Date(relDays[downNum].year, relDays[downNum].month-1, relDays[downNum].day);
						
						//cvt.title = cTitle;
						cvt.y = (cvt.height*j)+75;
						cvt.x = cvd.width + 30;
						yPos += cvt.y + cvt.height;
						addChild(cvt);
					}if(cTitle == relDays[downNum].dayName)
					{
						var cvu:CalendarViewUpcoming = new CalendarViewUpcoming(relDays[downNum]);
						cvu.y = (cvu.height*j) + yPos;
						cvu.x = cvd.width + 30;
						yPos += cvu.y;
						addChild(cvu);
					}
				}
			}else{
				for(var k:int; k < _calEvents.length; k++)
				{
					if(_calEvents[k].day >= todayNum.date && _calEvents[k].month >= todayNum.month)
					{
						relDays.push(_calEvents[z]);
					}
				}
				
				//trace(relDays[relDays.length-1].title);
				var calviewbase2:CalendarViewDetailFirst169 = new CalendarViewDetailFirst169(relDays[relDays.length-1]);
				calviewbase2.y = 75;
				
				
				var downNum1:int = relDays.length - 1;
				for(var t:int; t < 3; t++)
				{
					downNum1--;
					var cvd1:CalendarViewDetail169 = new CalendarViewDetail169(relDays[downNum1]);
					cvd1.y = (cvd1.height*d) + (calviewbase1.y + calviewbase1.height);
					addChild(cvd1);
				}
				addChild(calviewbase1);
				
				var cTitle2:String;
				var startUpcomingNum2:int = downNum1;
				var yPos1:int;
				for(var v:int; v < downNum1; v++)
				{
					downNum1--;
					cTitle = relDays[downNum].dayName;
					if(startUpcomingNum == downNum1+1)
					{
						var cvt1:CalendarViewUpcomingTitle169 = new CalendarViewUpcomingTitle169();
						cvt1.title = relDays[downNum1];
						//var dt4t:Date = new Date(relDays[downNum].year, relDays[downNum].month-1, relDays[downNum].day);
						
						//cvt.title = cTitle;
						cvt1.y = (cvt1.height*v)+75;
						cvt1.x = cvd1.width + 30;
						yPos1 += cvt1.y + cvt1.height;
						addChild(cvt1);
					}if(cTitle == relDays[downNum1].dayName)
					{
						var cvu1:CalendarViewUpcoming169 = new CalendarViewUpcoming169(relDays[downNum]);
						cvu1.y = (cvu1.height*v) + yPos1;
						cvu1.x = cvd1.width + 30;
						yPos += cvu1.y;
						addChild(cvu1);
					}
				}
				
			}
			
		
		}

	}
}