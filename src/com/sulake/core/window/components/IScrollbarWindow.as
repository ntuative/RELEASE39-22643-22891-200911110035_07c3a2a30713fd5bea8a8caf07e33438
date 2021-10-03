package com.sulake.core.window.components
{
   public interface IScrollbarWindow extends IInteractiveWindow
   {
       
      
      function set scrollV(param1:Number) : void;
      
      function get horizontal() : Boolean;
      
      function set scrollH(param1:Number) : void;
      
      function get scrollable() : IScrollableWindow;
      
      function get scrollV() : Number;
      
      function get scrollH() : Number;
      
      function get vertical() : Boolean;
      
      function set scrollable(param1:IScrollableWindow) : void;
   }
}
