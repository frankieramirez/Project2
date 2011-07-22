////////////////////////////////////////////////////////////////////////////
///// Author: Alexander Stojanovic
///// Year: 2010
///// Email: alex@rgbwired.com
///// Phone: 
///// Class Description:
////////////////////////////////////////////////////////////////////////////
//
package com.utils{
	/////////////////////////////////////////////////
	//////////// *** Custom classes *** /////////////
	//
	//
	/////////////////////////////////////////////////
	//
	/////////////////////////////////////////////////
	///////////// *** Flash classes *** /////////////
	//
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	//
	/////////////////////////////////////////////////
	//
	public class TextExcerpt extends MovieClip {
		private static var txtFieldRef:TextField;
		private static var txtLines:Number;
		private static var lineHeight:Number;
		private static var maxLines:Number;
		private static var totalChars:Number;
		private static var wrapWord:Boolean = true;
		private static var breakSingleLine:Boolean = false;
		//
		public static function setFixedText(tField:TextField, tmpText:String, wWord:Boolean = true) {
			wrapWord = wWord;
			txtFieldRef = tField;
			//
			if(tField.multiline == false){
				fitWords(tField, tmpText);
			} else {
				tField.text = tmpText;
				//
				txtLines = tField.numLines;
				lineHeight = tField.textHeight/txtLines;
				maxLines = Math.floor((tField.height/(tField.textHeight/tField.numLines)));
				totalChars = tmpText.length;
				//
				fitWords(tField, tmpText);
			}			
		}
		private static function getStringWords(tStr:String) {
			var words:Array = [];
			var newWord:String = "";
			var currWIndex:Number = 0;
			//
			for (var i = 0; i < tStr.length; i++) {
				var tmpChar = tStr.charAt(i);
				//
				if (i == 0) {
					currWIndex = i;
				} else {
					if (tStr.charAt(i - 1) == " " || tStr.charAt(i - 1) == "\r") {
						currWIndex = i;
					}
				}
				if (tmpChar == " " || tmpChar == "\r") {
					if (newWord.length != 0) {
						words.push({word: newWord, wordIndex: currWIndex});
					}
					newWord = "";
				} else if(i == tStr.length - 1){
					newWord += tmpChar;
					words.push({word: newWord, wordIndex: currWIndex});
				} else {
					newWord += tmpChar;
				}
			}
			return words;
		}
		private static function getClosestIndex(wArr:Array, breakIndex:Number) {
			var charLimit:Number = 0;
			var smallest:Number = wArr[wArr.length-1].wordIndex;
			//
			for (var i = 0; i < wArr.length; i++) {
				var tmpWord = wArr[i];
				var absDiff:Number = Math.abs(tmpWord.wordIndex + tmpWord.word.length + 3 - breakIndex);
				//
				if (absDiff < smallest) {
					smallest = absDiff;
					charLimit = tmpWord.wordIndex + tmpWord.word.length;
					//
					if(charLimit + 3 >= breakIndex && txtFieldRef.textWidth >= txtFieldRef.width){
						if(wArr[i-1] != undefined){
							charLimit = wArr[i-1].wordIndex + wArr[i-1].word.length;
						}
					}
				}
			}
			return charLimit;
		}
		private static function fitWords(tField:TextField, tStr:String) {
			var wObjs = getStringWords(tStr);
			//
			tField.text = "";
			var breakIndex:Number = tStr.length;
			var exceedLines:Boolean = false;
			breakSingleLine = false;
			//
			for (var i = 0; i < tStr.length; i++) {
				var tmpChar:String = tStr.charAt(i);
				tField.appendText(tmpChar);
				//
				if(tField.multiline){
					if (tField.numLines > maxLines) {
						breakIndex = i;
						exceedLines = true;
						break;
					}
				} else {
					if (tField.textWidth >= tField.width) {
						breakIndex = i;
						break;
					} else if(tmpChar == "\r" || tmpChar == "\n"){
						breakIndex = i;
						breakSingleLine = true;
						break;
					}
				}
			}
			if(breakIndex < 0){
				breakIndex = 0;
			}
			tField.text = tStr;
			var charLimit = getClosestIndex(wObjs, breakIndex);
			//
			if (charLimit != 0) {
				if(tField.multiline){
					if(exceedLines){
						if(wrapWord){
							tField.text = tStr.substr(0, charLimit) + "...";
						} else {
							tField.text = tStr.substr(0, breakIndex - 3) + "...";
						}
					} else {
						tField.text = tStr;
					}
				} else {
					if(wrapWord){
						if(breakSingleLine || tField.textWidth >= tField.width){
							tField.text = tStr.substr(0, charLimit) + "...";
						} else {
							tField.text = tStr.substr(0, charLimit);
						}
					} else {
						tField.text = tStr.substr(0, breakIndex - 3) + "...";
					}
				}
			} else{
				if(breakSingleLine){
					tField.text = tStr + "...";;
				} else {
					tField.text = tStr;
				}
			}
		}
	}
}