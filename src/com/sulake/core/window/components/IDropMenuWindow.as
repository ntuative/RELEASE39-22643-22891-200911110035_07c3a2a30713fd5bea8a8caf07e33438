package com.sulake.core.window.components
{
   public interface IDropMenuWindow extends IInteractiveWindow
   {
       
      
      function set selection(param1:int) : void;
      
      function populate(param1:Array) : void;
      
      function get selection() : int;
   }
}
