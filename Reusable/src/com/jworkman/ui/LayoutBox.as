package com.jworkman.ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class LayoutBox extends Sprite
	{
		
		private var _children:Array;
		
		private var _padding:int;
		
		public function LayoutBox(padding:int = 5)
		{
			super();
			
			_padding = padding;
			
			_children = [];
			
		}
		
		public function get padding():int
		{
			return _padding;
		}

		public function set padding(value:int):void
		{
			_padding = value;
			updateUI();
		}

		override public function addChild(child:DisplayObject):DisplayObject {
			
			_children.push(child);
			updateUI();
			
			
			return super.addChild(child);
			
			
		}
		
		public function clear():void
		{
			_children = [];
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
			
			updateUI();
		}
		
		
		private function updateUI():void {
			
			var yPos:int = 5;
			
			for each (var child:DisplayObject in _children) {
				
				child.y = yPos;
				yPos += child.height + _padding;
				
			}
			
		}
		
	}
}