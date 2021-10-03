package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.components.IFocusWindow;
   
   public interface IWindowFocusManagerService extends IDisposable
   {
       
      
      function removeFocusWindow(param1:IFocusWindow) : void;
      
      function registerFocusWindow(param1:IFocusWindow) : void;
   }
}
