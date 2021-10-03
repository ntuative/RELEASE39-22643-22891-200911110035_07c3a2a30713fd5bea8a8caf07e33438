package com.sulake.habbo.ui
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public interface IRoomWidgetHandler extends IDisposable
   {
       
      
      function getProcessedEvents() : Array;
      
      function set container(param1:IRoomWidgetHandlerContainer) : void;
      
      function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent;
      
      function getWidgetMessages() : Array;
      
      function update() : void;
      
      function get type() : String;
      
      function processEvent(param1:Event) : void;
   }
}
