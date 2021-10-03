package com.sulake.core.window.utils
{
   import flash.display.DisplayObject;
   
   public interface IMouseCursor
   {
       
      
      function get visible() : Boolean;
      
      function set visible(param1:Boolean) : void;
      
      function get x() : Number;
      
      function get y() : Number;
      
      function get type() : uint;
      
      function set type(param1:uint) : void;
      
      function defineCustomCursorType(param1:uint, param2:DisplayObject) : void;
   }
}
