package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import flash.display.DisplayObject;
   
   public interface IDisplayObjectWrapper extends IWindow
   {
       
      
      function getDisplayObject() : DisplayObject;
      
      function setDisplayObject(param1:DisplayObject) : void;
   }
}
