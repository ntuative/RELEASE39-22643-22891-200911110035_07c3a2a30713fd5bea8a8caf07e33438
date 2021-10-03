package com.sulake.core.window.utils
{
   import com.sulake.core.window.IWindow;
   
   public interface IWindowMouseListenerService
   {
       
      
      function get eventTypes() : Array;
      
      function begin(param1:IWindow, param2:uint = 0) : IWindow;
      
      function end(param1:IWindow) : IWindow;
      
      function set areaLimit(param1:uint) : void;
      
      function get areaLimit() : uint;
      
      function dispose() : void;
   }
}
