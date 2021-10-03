package com.sulake.habbo.ui
{
   import com.sulake.habbo.session.events.RoomSessionVoteEvent;
   import com.sulake.habbo.widget.RoomWidgetEnum;
   import com.sulake.habbo.widget.events.RoomWidgetFrameUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetVoteUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetVoteMessage;
   import flash.events.Event;
   
   public class VoteWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var _isDisposed:Boolean = false;
      
      public function VoteWidgetHandler()
      {
         super();
      }
      
      public function get type() : String
      {
         return RoomWidgetEnum.const_120;
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
         var _loc3_:* = null;
         if(_container == null || true)
         {
            return;
         }
         var _loc2_:RoomSessionVoteEvent = param1 as RoomSessionVoteEvent;
         if(_loc2_ == null)
         {
            return;
         }
         switch(param1.type)
         {
            case RoomSessionVoteEvent.const_119:
               _loc3_ = new RoomWidgetVoteUpdateEvent(RoomWidgetVoteUpdateEvent.const_119,_loc2_.question,_loc2_.choices);
               break;
            case RoomSessionVoteEvent.const_108:
               _loc3_ = new RoomWidgetVoteUpdateEvent(RoomWidgetVoteUpdateEvent.const_108,_loc2_.question,_loc2_.choices,_loc2_.votes,_loc2_.totalVotes);
         }
         if(_loc3_ == null)
         {
            return;
         }
         _container.events.dispatchEvent(_loc3_);
      }
      
      public function getWidgetMessages() : Array
      {
         return [RoomWidgetVoteMessage.const_120];
      }
      
      public function update() : void
      {
         _container.events.dispatchEvent(new RoomWidgetFrameUpdateEvent());
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:* = null;
         switch(param1.type)
         {
            case RoomWidgetVoteMessage.const_120:
               _loc2_ = param1 as RoomWidgetVoteMessage;
               if(_loc2_ == null)
               {
                  return null;
               }
               _container.roomSession.sendVote(_loc2_.vote);
               break;
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         var _loc1_:* = [];
         _loc1_.push(RoomSessionVoteEvent.const_119);
         _loc1_.push(RoomSessionVoteEvent.const_108);
         return _loc1_;
      }
      
      public function dispose() : void
      {
         _isDisposed = true;
         _container = null;
      }
   }
}
