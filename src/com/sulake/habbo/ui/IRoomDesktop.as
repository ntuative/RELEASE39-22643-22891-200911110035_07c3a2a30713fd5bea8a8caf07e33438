package com.sulake.habbo.ui
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public interface IRoomDesktop
   {
       
      
      function get events() : IEventDispatcher;
      
      function processEvent(param1:Event) : void;
   }
}
