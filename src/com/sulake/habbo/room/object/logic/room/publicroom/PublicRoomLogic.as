package com.sulake.habbo.room.object.logic.room.publicroom
{
   import com.sulake.habbo.room.RoomVariableEnum;
   import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
   import com.sulake.habbo.room.messages.RoomObjectRoomAdUpdateMessage;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.room.object.logic.room.RoomLogic;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.getTimer;
   
   public class PublicRoomLogic extends RoomLogic
   {
       
      
      private var var_969:int = 0;
      
      private var var_676:Boolean = false;
      
      public function PublicRoomLogic()
      {
         super();
      }
      
      public function adDelayTimeout() : void
      {
         if(object == null)
         {
            return;
         }
         var _loc1_:IRoomObjectModelController = object.getModel() as IRoomObjectModelController;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.setNumber(RoomObjectVariableEnum.const_450,Number(false));
      }
      
      override public function initialize(param1:XML) : void
      {
         super.initialize(param1);
         if(param1 == null || object == null)
         {
            return;
         }
         var _loc2_:IRoomObjectModelController = object.getModel() as IRoomObjectModelController;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.setString(RoomObjectVariableEnum.const_304,"");
         _loc2_.setString(RoomObjectVariableEnum.const_628,"");
         _loc2_.setNumber(RoomObjectVariableEnum.const_450,Number(false));
         var_676 = true;
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         if(param1 == null || object == null)
         {
            return;
         }
         var _loc2_:IRoomObjectModelController = object.getModel() as IRoomObjectModelController;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:RoomObjectRoomAdUpdateMessage = param1 as RoomObjectRoomAdUpdateMessage;
         if(_loc3_ != null)
         {
            switch(_loc3_.type)
            {
               case RoomObjectRoomAdUpdateMessage.const_774:
                  _loc2_.setString(RoomObjectVariableEnum.const_304,_loc3_.asset);
                  _loc2_.setString(RoomObjectVariableEnum.const_628,_loc3_.clickUrl);
                  _loc2_.setNumber(RoomObjectVariableEnum.const_450,Number(true));
                  var_969 = getTimer() + _loc2_.getNumber(RoomVariableEnum.const_858);
            }
         }
      }
      
      override public function update() : void
      {
         super.update();
         if(var_969 > 0 && getTimer() > var_969)
         {
            adDelayTimeout();
            var_969 = 0;
         }
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         super.mouseEvent(param1,param2);
         var _loc3_:RoomSpriteMouseEvent = param1;
         if(_loc3_ == null)
         {
            return;
         }
         if(object == null || param1 == null)
         {
            return;
         }
         var _loc4_:IRoomObjectModelController = object.getModel() as IRoomObjectModelController;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:int = object.getId();
         var _loc6_:String = object.getType();
         switch(_loc3_.type)
         {
            case MouseEvent.CLICK:
               if(_loc3_.spriteTag == RoomObjectVariableEnum.const_414)
               {
                  _loc7_ = _loc4_.getString(RoomObjectVariableEnum.const_628);
                  if(_loc7_ != null && _loc7_.indexOf("http") == 0)
                  {
                     _loc8_ = new URLRequest(_loc7_);
                     navigateToURL(_loc8_);
                  }
               }
               break;
            case MouseEvent.ROLL_OVER:
               if(_loc3_.spriteTag == RoomObjectVariableEnum.const_414)
               {
                  eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.const_306,_loc5_,_loc6_));
               }
               break;
            case MouseEvent.ROLL_OUT:
               if(_loc3_.spriteTag == RoomObjectVariableEnum.const_414)
               {
                  eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.const_267,_loc5_,_loc6_));
               }
         }
      }
   }
}
