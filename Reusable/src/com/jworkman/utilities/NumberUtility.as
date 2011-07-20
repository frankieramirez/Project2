package com.jworkman.utilities
{
	public class NumberUtility
	{
		public function NumberUtility()
		{
		}
		
		public static function roundToDecimal(value:Number, numOfPlaces:int):Number {
			
			var mod:Number = Math.pow(10, numOfPlaces);
			
			value *= mod;
			
			value = Math.round(value);
			
			value /= mod;
			
			return value;
			
		}
		
	}
}