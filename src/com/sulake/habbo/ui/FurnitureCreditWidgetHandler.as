package com.sulake.habbo.ui
{
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.widget.RoomWidgetEnum;
   import com.sulake.habbo.widget.events.RoomWidgetCreditFurniUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetCreditFurniRedeemMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   
   public class FurnitureCreditWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var _isDisposed:Boolean = false;
      
      public function FurnitureCreditWidgetHandler()
      {
         super();
      }
      
      public function get type() : String
      {
         return RoomWidgetEnum.const_455;
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
         if(_container != null && false && null != null)
         {
            _container.events.dispatchEvent(null);
         }
      }
      
      public function getWidgetMessages() : Array
      {
         return [RoomWidgetFurniToWidgetMessage.const_555,RoomWidgetCreditFurniRedeemMessage.const_593];
      }
      
      public function update() : void
      {
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:Number = NaN;
         var _loc8_:* = null;
         var _loc2_:Boolean = _container.roomSession.isRoomOwner || _container.sessionDataManager.isAnyRoomController;
         if(!_loc2_)
         {
            return null;
         }
         switch(param1.type)
         {
            case RoomWidgetFurniToWidgetMessage.const_555:
               _loc3_ = param1 as RoomWidgetFurniToWidgetMessage;
               _loc4_ = _container.roomEngine.getRoomObject(_loc3_.roomId,_loc3_.roomCategory,_loc3_.id,_loc3_.category);
               if(_loc4_ != null)
               {
                  _loc6_ = _loc4_.getModel();
                  if(_loc6_ != null)
                  {
                     _loc7_ = _loc6_.getNumber(RoomObjectVariableEnum.const_848);
                     _loc8_ = new RoomWidgetCreditFurniUpdateEvent(RoomWidgetCreditFurniUpdateEvent.const_656,_loc3_.id,_loc7_);
                     _container.events.dispatchEvent(_loc8_);
                  }
               }
               break;
            case RoomWidgetCreditFurniRedeemMessage.const_593:
               _loc5_ = param1 as RoomWidgetCreditFurniRedeemMessage;
               if(_container != null && false)
               {
                  _container.roomSession.sendCreditFurniRedeemMessage(_loc5_.objectId);
               }
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function dispose() : void
      {
         _isDisposed = true;
         _container = null;
      }
   }
}
