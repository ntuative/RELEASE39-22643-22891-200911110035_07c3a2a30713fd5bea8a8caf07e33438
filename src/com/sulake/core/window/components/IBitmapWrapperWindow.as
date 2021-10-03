package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import flash.display.BitmapData;
   
   public interface IBitmapWrapperWindow extends IWindow
   {
       
      
      function get disposesBitmap() : Boolean;
      
      function set disposesBitmap(param1:Boolean) : void;
      
      function set bitmap(param1:BitmapData) : void;
      
      function get bitmap() : BitmapData;
   }
}
