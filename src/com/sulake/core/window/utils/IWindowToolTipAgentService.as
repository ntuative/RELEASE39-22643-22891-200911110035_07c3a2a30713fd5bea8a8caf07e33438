package com.sulake.core.window.utils
{
   import com.sulake.core.window.IWindow;
   
   public interface IWindowToolTipAgentService
   {
       
      
      function begin(param1:IWindow, param2:uint = 0) : IWindow;
      
      function end(param1:IWindow) : IWindow;
      
      function dispose() : void;
   }
}
