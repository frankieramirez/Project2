package com.jworkman.utilities
{
	public class ConversionUtility
	{
		
		public function ConversionUtility() {
			
			
			
		}
		
		
		public function radiansToDegrees(radians:Number):Number {
			
			var numOfDegrees:Number = 57.2957795;
			var degrees:Number = radians * numOfDegrees;
			
			return degrees;
			
		}
		
		public function degreesToRadians(degrees:Number):Number {
			
			var numOfRadians:Number = 0.0174532925;
			var radians:Number = degrees * numOfRadians;
			
			return radians;
			
			
		}
		
		public function millisecondsToTime(milliseconds:int):String {
			
			var totalSeconds:Number = Math.round(milliseconds / 1000);
			
			
			var totalMinutes:Number = Math.floor(totalSeconds / 60);
			
			
			var totalHours:Number = Math.floor(totalMinutes / 60);
			
			totalSeconds = totalSeconds % 60;
			
			totalMinutes = totalMinutes % 60;
			
			return totalHours + ":" + totalMinutes + ":" + totalSeconds;
			
			
		}
		
		public function roundToDecimal(value:Number, numOfPlaces:int):Number {
			
			var mod:Number = Math.pow(10, numOfPlaces);
			
			value *= mod;
			
			value = Math.round(value);
			
			value /= mod;
			
			return value;
			
		}
		
		
	}
}