package com.sulake.core.window.graphics
{
   import com.sulake.core.runtime.ICoreUpdateReceiver;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContext;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public interface IWindowRenderer extends ICoreUpdateReceiver
   {
       
      
      function get allocatedByteCount() : uint;
      
      function registerRenderable(param1:IWindow) : void;
      
      function removeRenderable(param1:IWindow) : void;
      
      function render() : void;
      
      function flushRenderQueue() : void;
      
      function invalidate(param1:IWindowContext, param2:Rectangle) : void;
      
      function set debug(param1:Boolean) : void;
      
      function getDrawBufferForRenderable(param1:IWindow) : BitmapData;
      
      function addToRenderQueue(param1:IWindow, param2:Rectangle, param3:uint) : void;
   }
}
