package com.sulake.habbo.ui
{
   import com.sulake.habbo.widget.events.RoomWidgetShowPlaceholderEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public class PlaceholderWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function PlaceholderWidgetHandler()
      {
         super();
      }
      
      public function get type() : String
      {
         return null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function getWidgetMessages() : Array
      {
         return [RoomWidgetFurniToWidgetMessage.const_856];
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:* = null;
         var _loc3_:* = param1.type;
         switch(0)
         {
         }
         _loc2_ = new RoomWidgetShowPlaceholderEvent(RoomWidgetShowPlaceholderEvent.const_525);
         _container.events.dispatchEvent(_loc2_);
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return null;
      }
      
      public function dispose() : void
      {
         _container = null;
      }
   }
}
