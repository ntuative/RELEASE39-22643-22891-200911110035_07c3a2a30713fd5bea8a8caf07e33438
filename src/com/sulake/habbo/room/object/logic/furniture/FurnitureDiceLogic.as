package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.events.MouseEvent;
   
   public class FurnitureDiceLogic extends FurnitureLogic
   {
       
      
      public function FurnitureDiceLogic()
      {
         super();
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
                  if(param1.spriteTag == "activate" || object.getState(0) == 0 || object.getState(0) == 100)
                  {
                     _loc5_ = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.const_362,_loc3_,_loc4_);
                  }
                  else if(param1.spriteTag == "deactivate")
                  {
                     _loc5_ = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.const_363,_loc3_,_loc4_);
                  }
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
   }
}
