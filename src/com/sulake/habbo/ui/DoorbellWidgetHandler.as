package com.sulake.habbo.ui
{
   import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
   import com.sulake.habbo.widget.RoomWidgetEnum;
   import com.sulake.habbo.widget.events.RoomWidgetDoorbellEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetLetUserInMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public class DoorbellWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var _isDisposed:Boolean = false;
      
      public function DoorbellWidgetHandler()
      {
         super();
      }
      
      public function get type() : String
      {
         return RoomWidgetEnum.const_92;
      }
      
      public function get disposed() : Boolean
      {
         return _isDisposed;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc2_:* = null;
         switch(param1.type)
         {
            case RoomSessionDoorbellEvent.const_92:
               _loc2_ = param1 as RoomSessionDoorbellEvent;
               if(_loc2_ == null)
               {
                  return;
               }
               _container.events.dispatchEvent(new RoomWidgetDoorbellEvent(RoomWidgetDoorbellEvent.const_683,_loc2_.userName));
               break;
            case RoomSessionDoorbellEvent.const_105:
               _loc2_ = param1 as RoomSessionDoorbellEvent;
               if(_loc2_ == null)
               {
                  return;
               }
               _container.events.dispatchEvent(new RoomWidgetDoorbellEvent(RoomWidgetDoorbellEvent.const_105,_loc2_.userName));
               break;
         }
      }
      
      public function getWidgetMessages() : Array
      {
         return [RoomWidgetLetUserInMessage.const_597];
      }
      
      public function update() : void
      {
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:* = null;
         switch(param1.type)
         {
            case RoomWidgetLetUserInMessage.const_597:
               _loc2_ = param1 as RoomWidgetLetUserInMessage;
               _container.roomSession.letUserIn(_loc2_.userName,_loc2_.canEnter);
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [RoomSessionDoorbellEvent.const_92,RoomSessionDoorbellEvent.const_105];
      }
      
      public function dispose() : void
      {
         _isDisposed = true;
         _container = null;
      }
   }
}
