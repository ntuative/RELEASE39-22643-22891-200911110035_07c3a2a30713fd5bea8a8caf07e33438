package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.events.MouseEvent;
   
   public class FurnitureStickieLogic extends FurnitureLogic
   {
       
      
      public function FurnitureStickieLogic()
      {
         super();
      }
      
      override public function initialize(param1:XML) : void
      {
         super.initialize(param1);
         setColorIndexFromItemData();
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(object == null)
         {
            return;
         }
         switch(param1.type)
         {
            case MouseEvent.DOUBLE_CLICK:
               if(eventDispatcher != null)
               {
                  _loc3_ = object.getId();
                  _loc4_ = object.getType();
                  _loc5_ = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.const_456,_loc3_,_loc4_);
                  if(_loc5_ != null)
                  {
                     eventDispatcher.dispatchEvent(_loc5_);
                  }
               }
               break;
            default:
               super.mouseEvent(param1,param2);
         }
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc2_:* = null;
         super.processUpdateMessage(param1);
         if(param1 is RoomObjectItemDataUpdateMessage)
         {
            _loc2_ = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.const_102,object.getId(),object.getType());
            if(_loc2_ != null)
            {
               eventDispatcher.dispatchEvent(_loc2_);
            }
         }
         setColorIndexFromItemData();
      }
      
      private function setColorIndexFromItemData() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(object != null)
         {
            _loc1_ = object.getModel().getString(RoomObjectVariableEnum.const_138);
            _loc2_ = new Array("9CCEFF","FF9CFF","9CFF9C","FFFF33");
            _loc3_ = _loc2_.indexOf(_loc1_);
            if(_loc3_ < 0)
            {
               _loc3_ = 3;
            }
            object.getModelController().setNumber(RoomObjectVariableEnum.const_201,_loc3_ + 1);
         }
      }
   }
}
