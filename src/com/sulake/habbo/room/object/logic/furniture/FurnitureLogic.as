package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.room.object.logic.MovingObjectLogic;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomObjectMouseEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import com.sulake.room.utils.XMLValidator;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class FurnitureLogic extends MovingObjectLogic
   {
       
      
      private var var_867:Number = 0;
      
      private var var_588:Boolean = false;
      
      private var var_1637:Number = 0;
      
      private var var_1636:Number = 0;
      
      private var var_1060:Number = 0;
      
      private var var_869:Number = 0;
      
      private var var_868:Number = 0;
      
      private var var_211:Array;
      
      public function FurnitureLogic()
      {
         var_211 = [];
         super();
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc2_:IRoomObjectModelController = object.getModelController();
         var _loc3_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc3_ != null)
         {
            object.setState(_loc3_.state,0);
            if(_loc2_ != null)
            {
               _loc2_.setString(RoomObjectVariableEnum.const_138,_loc3_.data);
            }
            return;
         }
         var _loc4_:RoomObjectItemDataUpdateMessage = param1 as RoomObjectItemDataUpdateMessage;
         if(_loc4_ != null)
         {
            if(_loc2_ != null)
            {
               _loc2_.setString(RoomObjectVariableEnum.const_933,_loc4_.itemData);
            }
            return;
         }
         var_588 = false;
         super.processUpdateMessage(param1);
      }
      
      override public function initialize(param1:XML) : void
      {
         var _loc7_:* = null;
         var _loc8_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var_869 = 0;
         var_868 = 0;
         var_867 = 0;
         var_211 = [];
         var _loc2_:XMLList = param1.model.dimensions;
         if(_loc2_.length() == 0)
         {
            return;
         }
         var _loc3_:XMLList = _loc2_.@x;
         if(_loc3_.length() == 1)
         {
            var_869 = Number(_loc3_);
         }
         _loc3_ = _loc2_.@y;
         if(_loc3_.length() == 1)
         {
            var_868 = Number(_loc3_);
         }
         _loc3_ = _loc2_.@z;
         if(_loc3_.length() == 1)
         {
            var_867 = Number(_loc3_);
         }
         var_1637 = var_869 / 2;
         var_1636 = var_868 / 2;
         _loc3_ = _loc2_.@centerZ;
         if(_loc3_.length() == 1)
         {
            var_1060 = Number(_loc3_);
         }
         else
         {
            var_1060 = var_867 / 2;
         }
         var _loc4_:XMLList = param1.model.directions.direction;
         var _loc5_:* = ["id"];
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length())
         {
            _loc7_ = _loc4_[_loc6_];
            if(XMLValidator.checkRequiredAttributes(_loc7_,_loc5_))
            {
               _loc8_ = parseInt(_loc7_.@id);
               var_211.push(_loc8_);
            }
            _loc6_++;
         }
         var_211.sort(Array.NUMERIC);
         if(object == null || object.getModelController() == null)
         {
            return;
         }
         object.getModelController().setNumber(RoomObjectVariableEnum.const_424,var_869,true);
         object.getModelController().setNumber(RoomObjectVariableEnum.const_635,var_868,true);
         object.getModelController().setNumber(RoomObjectVariableEnum.const_810,var_867,true);
         object.getModelController().setNumber(RoomObjectVariableEnum.const_1213,var_1637,true);
         object.getModelController().setNumber(RoomObjectVariableEnum.const_1144,var_1636,true);
         object.getModelController().setNumber(RoomObjectVariableEnum.const_872,var_1060,true);
         object.getModelController().setNumberArray(RoomObjectVariableEnum.const_686,var_211,true);
         object.getModelController().setNumber(RoomObjectVariableEnum.const_158,1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_211 = null;
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(object == null)
         {
            return;
         }
         var _loc3_:* = null;
         switch(param1.type)
         {
            case MouseEvent.ROLL_OVER:
               if(!var_588)
               {
                  _loc3_ = object.getModel() as IRoomObjectModelController;
                  _loc9_ = _loc3_.getString(RoomObjectVariableEnum.const_311);
                  if(_loc9_ != null && _loc9_.indexOf("http") == 0)
                  {
                     eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.const_306,_loc6_,_loc7_));
                  }
                  var_588 = true;
               }
               break;
            case MouseEvent.ROLL_OUT:
               if(var_588)
               {
                  _loc3_ = object.getModel() as IRoomObjectModelController;
                  _loc9_ = _loc3_.getString(RoomObjectVariableEnum.const_311);
                  if(_loc9_ != null && _loc9_.indexOf("http") == 0)
                  {
                     eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.const_267,_loc6_,_loc7_));
                  }
                  var_588 = false;
               }
               break;
            case MouseEvent.DOUBLE_CLICK:
               _loc6_ = object.getId();
               _loc7_ = object.getType();
               _loc3_ = object.getModel() as IRoomObjectModelController;
               _loc9_ = _loc3_.getString(RoomObjectVariableEnum.const_311);
               if(_loc9_ != null && _loc9_.indexOf("http") == 0 && param1.shiftKey == false && param1.altKey == false)
               {
                  _loc10_ = new URLRequest(_loc9_);
                  navigateToURL(_loc10_);
               }
            case MouseEvent.CLICK:
               _loc6_ = object.getId();
               _loc7_ = object.getType();
               if(eventDispatcher != null)
               {
                  _loc8_ = new RoomObjectMouseEvent(RoomObjectMouseEvent.const_180,_loc6_,_loc7_,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
                  eventDispatcher.dispatchEvent(_loc8_);
               }
               Logger.log("* clicked on " + _loc6_ + "/" + _loc7_);
               break;
            case MouseEvent.MOUSE_DOWN:
               _loc6_ = object.getId();
               _loc7_ = object.getType();
               if(eventDispatcher != null)
               {
                  _loc8_ = new RoomObjectMouseEvent(RoomObjectMouseEvent.const_334,_loc6_,_loc7_,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
                  eventDispatcher.dispatchEvent(_loc8_);
               }
         }
      }
   }
}
