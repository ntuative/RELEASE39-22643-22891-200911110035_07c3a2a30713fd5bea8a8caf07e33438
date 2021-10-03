package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.utils.IMargins;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.text.StyleSheet;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   
   public interface ITextWindow extends IWindow, IScrollableWindow
   {
       
      
      function set thickness(param1:Number) : void;
      
      function replaceText(param1:int, param2:int, param3:String) : void;
      
      function set sharpness(param1:Number) : void;
      
      function get margins() : IMargins;
      
      function set spacing(param1:Number) : void;
      
      function set bold(param1:Boolean) : void;
      
      function get kerning() : Boolean;
      
      function setTextFormat(param1:TextFormat, param2:int = -1, param3:int = -1) : void;
      
      function set gridFitType(param1:String) : void;
      
      function get bold() : Boolean;
      
      function set wordWrap(param1:Boolean) : void;
      
      function get borderColor() : uint;
      
      function set fontFace(param1:String) : void;
      
      function get numLines() : int;
      
      function getLineOffset(param1:int) : int;
      
      function set displayAsPassword(param1:Boolean) : void;
      
      function set kerning(param1:Boolean) : void;
      
      function set autoSize(param1:String) : void;
      
      function get defaultTextFormat() : TextFormat;
      
      function getImageReference(param1:String) : DisplayObject;
      
      function set underline(param1:Boolean) : void;
      
      function get textWidth() : Number;
      
      function get embedFonts() : Boolean;
      
      function get border() : Boolean;
      
      function get text() : String;
      
      function get styleSheet() : StyleSheet;
      
      function get italic() : Boolean;
      
      function set maxChars(param1:int) : void;
      
      function set selectable(param1:Boolean) : void;
      
      function get textHeight() : Number;
      
      function set borderColor(param1:uint) : void;
      
      function get textColor() : uint;
      
      function getLineText(param1:int) : String;
      
      function getFirstCharInParagraph(param1:int) : int;
      
      function get textBackground() : Boolean;
      
      function get multiline() : Boolean;
      
      function getParagraphLength(param1:int) : int;
      
      function get sharpness() : Number;
      
      function get spacing() : Number;
      
      function get gridFitType() : String;
      
      function set defaultTextFormat(param1:TextFormat) : void;
      
      function get fontFace() : String;
      
      function get displayAsPassword() : Boolean;
      
      function get autoSize() : String;
      
      function get underline() : Boolean;
      
      function get selectable() : Boolean;
      
      function set antiAliasType(param1:String) : void;
      
      function set border(param1:Boolean) : void;
      
      function get maxChars() : int;
      
      function set multiline(param1:Boolean) : void;
      
      function set styleSheet(param1:StyleSheet) : void;
      
      function set embedFonts(param1:Boolean) : void;
      
      function getCharIndexAtPoint(param1:Number, param2:Number) : int;
      
      function set textBackgroundColor(param1:uint) : void;
      
      function set fontSize(param1:uint) : void;
      
      function set text(param1:String) : void;
      
      function get length() : int;
      
      function set italic(param1:Boolean) : void;
      
      function get antiAliasType() : String;
      
      function set textColor(param1:uint) : void;
      
      function getCharBoundaries(param1:int) : Rectangle;
      
      function appendText(param1:String) : void;
      
      function get textBackgroundColor() : uint;
      
      function get fontSize() : uint;
      
      function get wordWrap() : Boolean;
      
      function getLineIndexAtPoint(param1:Number, param2:Number) : int;
      
      function set textBackground(param1:Boolean) : void;
      
      function set htmlText(param1:String) : void;
      
      function get htmlText() : String;
      
      function getLineMetrics(param1:int) : TextLineMetrics;
      
      function getTextFormat(param1:int = -1, param2:int = -1) : TextFormat;
      
      function get thickness() : Number;
      
      function getLineIndexOfChar(param1:int) : int;
      
      function get bottomScrollV() : int;
      
      function getLineLength(param1:int) : int;
   }
}
