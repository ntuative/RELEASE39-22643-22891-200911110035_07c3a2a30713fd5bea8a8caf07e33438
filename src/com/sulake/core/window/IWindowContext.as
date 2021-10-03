package com.sulake.core.window
{
   import com.sulake.core.window.components.IDesktopWindow;
   import com.sulake.core.window.utils.IInternalWindowServices;
   import com.sulake.core.window.utils.IMouseCursor;
   import com.sulake.core.window.utils.IWindowParser;
   import flash.geom.Rectangle;
   
   public interface IWindowContext
   {
       
      
      function getLastError() : Error;
      
      function getWindowServices() : IInternalWindowServices;
      
      function getWindowParser() : IWindowParser;
      
      function getLastErrorCode() : uint;
      
      function findWindowByName(param1:String) : IWindow;
      
      function getMouseCursor() : IMouseCursor;
      
      function registerLocalizationListener(param1:String, param2:IWindow) : void;
      
      function removeLocalizationListener(param1:String, param2:IWindow) : void;
      
      function getDesktopWindow() : IDesktopWindow;
      
      function destroy(param1:IWindow) : Boolean;
      
      function invalidate(param1:IWindow, param2:Rectangle, param3:uint) : Boolean;
      
      function create(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:Rectangle, param7:Function, param8:IWindow, param9:uint, param10:Array = null, param11:Array = null) : IWindow;
   }
}
