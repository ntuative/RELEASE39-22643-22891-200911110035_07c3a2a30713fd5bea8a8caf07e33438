package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowContainer;
   
   public interface IDesktopWindow extends IWindowContainer, IDisplayObjectWrapper
   {
       
      
      function get mouseX() : int;
      
      function get mouseY() : int;
   }
}
