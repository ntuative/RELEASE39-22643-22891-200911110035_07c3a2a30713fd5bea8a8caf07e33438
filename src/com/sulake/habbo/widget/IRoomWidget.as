package com.sulake.habbo.widget
{
   import com.sulake.core.window.IWindow;
   import flash.events.IEventDispatcher;
   
   public interface IRoomWidget
   {
       
      
      function registerUpdateEvents(param1:IEventDispatcher) : void;
      
      function set messageListener(param1:IRoomWidgetMessageListener) : void;
      
      function get mainWindow() : IWindow;
      
      function unregisterUpdateEvents(param1:IEventDispatcher) : void;
      
      function dispose() : void;
   }
}
