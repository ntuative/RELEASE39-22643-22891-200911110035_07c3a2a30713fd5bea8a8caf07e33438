package com.sulake.habbo.room
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.LookToMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.GetItemDataMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveAvatarMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveObjectMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.PickupObjectMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.PlaceObjectMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.RemoveItemMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.SetItemDataMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.UseWallItemMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.DiceOffMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.EnterOneWayDoorMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetRandomStateMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.SpinWheelOfFortuneMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.ThrowDiceMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.publicroom.ChangeRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.publicroom.TryBusMessageComposer;
   import com.sulake.habbo.room.events.RoomEngineDimmerStateEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomObjectDimmerStateUpdateEvent;
   import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
   import com.sulake.habbo.room.events.RoomObjectMoveEvent;
   import com.sulake.habbo.room.events.RoomObjectRoomActionEvent;
   import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
   import com.sulake.habbo.room.events.RoomObjectSoundMachineStateUpdateEvent;
   import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
   import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
   import com.sulake.habbo.room.events.RoomObjectWallMouseEvent;
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectAvatarSelectedMessage;
   import com.sulake.habbo.room.messages.RoomObjectVisibilityUpdateMessage;
   import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
   import com.sulake.habbo.room.object.RoomObjectOperationEnum;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.room.utils.LegacyWallGeometry;
   import com.sulake.habbo.room.utils.SelectedRoomObjectData;
   import com.sulake.habbo.room.utils.TileHeightMap;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomObjectMouseEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.renderer.IRoomRenderingCanvasMouseListener;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   
   public class RoomObjectEventHandler implements IRoomRenderingCanvasMouseListener
   {
       
      
      private var _roomEngine:IRoomEngineServices = null;
      
      private var var_276:Map = null;
      
      private var var_899:int = -1;
      
      public function RoomObjectEventHandler(param1:IRoomEngineServices)
      {
         super();
         var_276 = new Map();
         _roomEngine = param1;
      }
      
      public function method_7(param1:int, param2:int, param3:int, param4:int, param5:int, param6:String = null) : Boolean
      {
         var _loc7_:IVector3d = new Vector3d(-100,-100);
         var _loc8_:IVector3d = new Vector3d(0);
         setSelectedObjectData(param1,param2,param3,param4,_loc7_,_loc8_,RoomObjectOperationEnum.OBJECT_PLACE,param5,param6);
         if(_roomEngine != null)
         {
            _roomEngine.setObjectMoverIconSprite(param5,param4,false,param6);
            _roomEngine.setObjectMoverIconSpriteVisible(false);
         }
         return true;
      }
      
      public function getSelectedAvatarId() : int
      {
         return var_899;
      }
      
      private function setSelectedObjectData(param1:int, param2:int, param3:int, param4:int, param5:IVector3d, param6:IVector3d, param7:String, param8:int = 0, param9:String = null) : void
      {
         resetSelectedObjectData(param1,param2);
         if(_roomEngine == null)
         {
            return;
         }
         var _loc10_:SelectedRoomObjectData = new SelectedRoomObjectData(param3,param4,param7,param5,param6,param8,param9);
         _roomEngine.setSelectedObjectData(param1,param2,_loc10_);
      }
      
      private function validateWallItemLocation(param1:IRoomObject, param2:IVector3d, param3:IVector3d, param4:IVector3d, param5:Number, param6:Number, param7:SelectedRoomObjectData) : Vector3d
      {
         if(param1 == null || param1.getModel() == null || param2 == null || param3 == null || param4 == null || param7 == null)
         {
            return null;
         }
         var _loc8_:Number = param1.getModel().getNumber(RoomObjectVariableEnum.const_424);
         var _loc9_:Number = param1.getModel().getNumber(RoomObjectVariableEnum.const_810);
         var _loc10_:Number = param1.getModel().getNumber(RoomObjectVariableEnum.const_872);
         if(param5 < _loc8_ / 2 || param5 > param3.length - _loc8_ / 2 || param6 < _loc10_ || param6 > param4.length - (_loc9_ - _loc10_))
         {
            return null;
         }
         var _loc11_:Vector3d = Vector3d.sum(Vector3d.product(param3,param5 / param3.length),Vector3d.product(param4,param6 / param4.length));
         return Vector3d.sum(param2,_loc11_);
      }
      
      private function getValidFurnitureDirection(param1:IRoomObjectController, param2:Boolean) : int
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1 == null || param1.getModel() == null)
         {
            return 0;
         }
         var _loc3_:* = null;
         if(param1.getModel() != null)
         {
            _loc3_ = param1.getModel().getNumberArray(RoomObjectVariableEnum.const_686);
         }
         var _loc4_:int = param1.getDirection().x;
         if(_loc3_ != null && _loc3_.length > 0)
         {
            _loc5_ = _loc3_.indexOf(_loc4_);
            if(_loc5_ < 0)
            {
               _loc5_ = 0;
               _loc6_ = 0;
               while(_loc6_ < _loc3_.length)
               {
                  if(_loc4_ <= _loc3_[_loc6_])
                  {
                     break;
                  }
                  _loc5_++;
                  _loc6_++;
               }
               _loc5_ %= _loc3_.length;
            }
            if(param2)
            {
               _loc5_ = (_loc5_ + 1) % _loc3_.length;
            }
            else
            {
               _loc5_ = (_loc5_ - 1 + _loc3_.length) % _loc3_.length;
            }
            _loc4_ = _loc3_[_loc5_];
         }
         return _loc4_;
      }
      
      private function handleObjectWidgetRequestEvent(param1:RoomObjectEvent, param2:int, param3:int) : void
      {
         if(_roomEngine == null || param1 == null)
         {
            return;
         }
         var _loc4_:int = param1.objectId;
         var _loc5_:String = param1.objectType;
         var _loc6_:int = _roomEngine.getRoomObjectCategory(_loc5_);
         var _loc7_:IEventDispatcher = _roomEngine.events;
         if(_loc7_ != null)
         {
            switch(param1.type)
            {
               case RoomObjectWidgetRequestEvent.const_107:
                  _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.const_107,param2,param3,_loc4_,_loc6_));
                  break;
               case RoomObjectWidgetRequestEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI:
                  _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI,param2,param3,_loc4_,_loc6_));
                  break;
               case RoomObjectWidgetRequestEvent.const_102:
                  _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.const_102,param2,param3,_loc4_,_loc6_));
                  break;
               case RoomObjectWidgetRequestEvent.const_114:
                  _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.const_114,param2,param3,_loc4_,_loc6_));
                  break;
               case RoomObjectWidgetRequestEvent.const_116:
                  _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.const_116,param2,param3,_loc4_,_loc6_));
                  break;
               case RoomObjectWidgetRequestEvent.ROOM_OBJECT_WIDGET_REQUEST_ECOTRONBOX:
                  _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.ROOM_OBJECT_WIDGET_REQUEST_ECOTRONBOX,param2,param3,_loc4_,_loc6_));
                  break;
               case RoomObjectWidgetRequestEvent.const_104:
                  _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.const_104,param2,param3,_loc4_,_loc6_));
                  break;
               case RoomObjectWidgetRequestEvent.const_82:
                  _loc7_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.const_82,param2,param3,_loc4_,_loc6_));
            }
         }
      }
      
      private function handleObjectRandomStateChange(param1:RoomObjectStateChangeEvent, param2:int, param3:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         changeObjectState(param2,param3,param1.objectId,param1.objectType,param1.param,true);
      }
      
      private function handleObjectStateChange(param1:RoomObjectStateChangeEvent, param2:int, param3:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         changeObjectState(param2,param3,param1.objectId,param1.objectType,param1.param,false);
      }
      
      private function handleFurnitureMove(param1:IRoomObjectController, param2:SelectedRoomObjectData, param3:int, param4:int, param5:TileHeightMap) : Boolean
      {
         if(param1 == null || param2 == null)
         {
            return false;
         }
         var _loc6_:Vector3d = new Vector3d();
         _loc6_.assign(param1.getDirection());
         param1.setDirection(param2.dir);
         var _loc7_:Vector3d = new Vector3d(param3,param4,0);
         var _loc8_:Vector3d = new Vector3d();
         _loc8_.assign(param1.getDirection());
         var _loc9_:Vector3d = validateFurnitureLocation(param1,_loc7_,param2.loc,param2.dir,param5);
         if(_loc9_ == null)
         {
            _loc8_.x = getValidFurnitureDirection(param1,true);
            param1.setDirection(_loc8_);
            _loc9_ = validateFurnitureLocation(param1,_loc7_,param2.loc,param2.dir,param5);
         }
         if(_loc9_ == null)
         {
            param1.setDirection(_loc6_);
            return false;
         }
         param1.setLocation(_loc9_);
         if(_loc8_)
         {
            param1.setDirection(_loc8_);
         }
         return true;
      }
      
      public function dispose() : void
      {
         if(var_276 != null)
         {
            var_276.dispose();
            var_276 = null;
         }
         _roomEngine = null;
      }
      
      public function modifyWallItemData(param1:int, param2:int, param3:int, param4:String) : Boolean
      {
         if(_roomEngine == null || true)
         {
            return false;
         }
         _roomEngine.connection.send(new SetItemDataMessageComposer(param3,param4,param1,param2));
         return true;
      }
      
      private function handleObjectJukeboxEvent(param1:RoomObjectEvent, param2:int, param3:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         switch(param1.type)
         {
            case RoomObjectFurnitureActionEvent.const_335:
               _roomEngine.events.dispatchEvent(new RoomObjectSoundMachineStateUpdateEvent(param1.objectId,param1.objectType,RoomObjectSoundMachineStateUpdateEvent.const_1071));
               break;
            case RoomObjectFurnitureActionEvent.const_457:
               _roomEngine.events.dispatchEvent(new RoomObjectSoundMachineStateUpdateEvent(param1.objectId,param1.objectType,RoomObjectSoundMachineStateUpdateEvent.const_752));
         }
      }
      
      private function walkTo(param1:int, param2:int) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         if(false)
         {
            _roomEngine.connection.send(new MoveAvatarMessageComposer(param1,param2));
         }
      }
      
      private function useObject(param1:int, param2:int, param3:int, param4:String, param5:String) : void
      {
         if(_roomEngine != null && false)
         {
            switch(param5)
            {
               case RoomObjectFurnitureActionEvent.const_362:
                  _roomEngine.connection.send(new ThrowDiceMessageComposer(param3));
                  break;
               case RoomObjectFurnitureActionEvent.const_363:
                  _roomEngine.connection.send(new DiceOffMessageComposer(param3));
                  break;
               case RoomObjectFurnitureActionEvent.const_342:
                  _roomEngine.connection.send(new SpinWheelOfFortuneMessageComposer(param3));
                  break;
               case RoomObjectFurnitureActionEvent.const_456:
                  _roomEngine.connection.send(new GetItemDataMessageComposer(param3));
                  break;
               case RoomObjectFurnitureActionEvent.const_399:
                  _roomEngine.connection.send(new EnterOneWayDoorMessageComposer(param3));
            }
         }
      }
      
      private function handleObjectDimmerStateEvent(param1:RoomObjectEvent, param2:int, param3:int) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc4_:int = param1.objectId;
         if(_roomEngine != null && false)
         {
            switch(param1.type)
            {
               case RoomObjectDimmerStateUpdateEvent.const_60:
                  _loc5_ = param1 as RoomObjectDimmerStateUpdateEvent;
                  if(_loc5_ != null)
                  {
                     _loc6_ = new RoomEngineDimmerStateEvent(param2,param3,_loc5_.state,_loc5_.presetId,_loc5_.effectId,_loc5_.color,_loc5_.brightness);
                     _roomEngine.events.dispatchEvent(_loc6_);
                  }
            }
         }
      }
      
      private function handleSelectedObjectRemove(param1:RoomObjectEvent, param2:int, param3:int) : void
      {
         setSelectedAvatar(param2,param3,0,false);
      }
      
      private function updateSelectedObjectData(param1:int, param2:int, param3:int, param4:int, param5:IVector3d, param6:IVector3d, param7:String, param8:int = 0, param9:String = null) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         var _loc10_:SelectedRoomObjectData = new SelectedRoomObjectData(param3,param4,param7,param5,param6,param8,param9);
         _roomEngine.setSelectedObjectData(param1,param2,_loc10_);
      }
      
      private function placeObject(param1:int, param2:int) : void
      {
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc3_:SelectedRoomObjectData = getSelectedObjectData(param1,param2);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:int = _loc3_.id;
         var _loc5_:int = _loc3_.category;
         if(_roomEngine != null && false)
         {
            _loc6_ = "";
            _loc7_ = 0;
            _loc8_ = 0;
            _loc9_ = 0;
            _loc10_ = _roomEngine.getRoomObject(param1,param2,_loc4_,_loc5_) as IRoomObjectController;
            if(_loc10_ != null)
            {
               _loc9_ = _loc10_.getDirection().x;
               _loc11_ = _loc10_.getLocation();
               if(_loc5_ == RoomObjectCategoryEnum.const_35)
               {
                  _loc7_ = _loc11_.x;
                  _loc8_ = _loc11_.y;
               }
               else if(_loc5_ == RoomObjectCategoryEnum.const_28)
               {
                  _loc12_ = _roomEngine.getLegacyGeometry(param1,param2);
                  if(_loc12_ != null)
                  {
                     _loc6_ = _loc12_.getOldLocationString(_loc11_,_loc9_);
                  }
               }
               _loc9_ = (_loc9_ / 45 % 8 + 8) % 8;
               _roomEngine.connection.send(new PlaceObjectMessageComposer(_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_));
            }
         }
         if(_roomEngine && false)
         {
            _roomEngine.events.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.const_318,param1,param2,_loc4_,_loc5_));
         }
         resetSelectedObjectData(param1,param2);
      }
      
      private function handleWallItemMove(param1:IRoomObjectController, param2:SelectedRoomObjectData, param3:IVector3d, param4:IVector3d, param5:IVector3d, param6:Number, param7:Number, param8:Number) : Boolean
      {
         if(param1 == null || param2 == null)
         {
            return false;
         }
         var _loc9_:Vector3d = new Vector3d(param8);
         var _loc10_:Vector3d = validateWallItemLocation(param1,param3,param4,param5,param6,param7,param2);
         if(_loc10_ == null)
         {
            return false;
         }
         param1.setLocation(_loc10_);
         param1.setDirection(_loc9_);
         return true;
      }
      
      private function resetSelectedObjectData(param1:int, param2:int) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(_roomEngine == null)
         {
            return;
         }
         if(_roomEngine != null)
         {
            _roomEngine.removeObjectMoverIconSprite();
         }
         var _loc3_:SelectedRoomObjectData = getSelectedObjectData(param1,param2);
         if(_loc3_ != null)
         {
            if(_loc3_.operation == RoomObjectOperationEnum.OBJECT_MOVE)
            {
               _loc4_ = _roomEngine.getRoomObject(param1,param2,_loc3_.id,_loc3_.category) as IRoomObjectController;
               if(_loc4_ != null)
               {
                  _loc4_.setLocation(_loc3_.loc);
                  _loc4_.setDirection(_loc3_.dir);
               }
               setObjectAlphaMultiplier(_loc4_,1);
            }
            if(_loc3_.operation == RoomObjectOperationEnum.OBJECT_PLACE)
            {
               _loc5_ = _loc3_.id;
               _loc6_ = _loc3_.category;
               switch(_loc6_)
               {
                  case RoomObjectCategoryEnum.const_35:
                     _roomEngine.disposeObjectFurniture(param1,param2,_loc5_);
                     break;
                  case RoomObjectCategoryEnum.const_28:
                     _roomEngine.disposeObjectWallItem(param1,param2,_loc5_);
               }
            }
            _roomEngine.setSelectedObjectData(param1,param2,null);
         }
      }
      
      public function setSelectedObject(param1:int, param2:int, param3:int, param4:int) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         var _loc5_:IEventDispatcher = _roomEngine.events;
         if(_loc5_ == null)
         {
            return;
         }
         switch(param4)
         {
            case RoomObjectCategoryEnum.const_42:
            case RoomObjectCategoryEnum.const_35:
            case RoomObjectCategoryEnum.const_28:
               if(param4 == RoomObjectCategoryEnum.const_42)
               {
                  setSelectedAvatar(param1,param2,param3,true);
               }
               else
               {
                  setSelectedAvatar(param1,param2,0,false);
               }
               _loc5_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.const_566,param1,param2,param3,param4));
         }
      }
      
      private function setObjectAlphaMultiplier(param1:IRoomObjectController, param2:Number) : void
      {
         if(param1 != null && param1.getModelController() != null)
         {
            param1.getModelController().setNumber(RoomObjectVariableEnum.const_158,param2);
         }
      }
      
      private function handleObjectPlace(param1:RoomObjectMouseEvent, param2:int, param3:int) : void
      {
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:Boolean = false;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         if(param1 == null || _roomEngine == null)
         {
            return;
         }
         var _loc4_:IEventDispatcher = _roomEngine.events;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:SelectedRoomObjectData = getSelectedObjectData(param2,param3);
         if(_loc5_ == null)
         {
            return;
         }
         var _loc6_:IRoomObjectController = _roomEngine.getRoomObject(param2,param3,_loc5_.id,_loc5_.category) as IRoomObjectController;
         var _loc7_:Boolean = false;
         var _loc8_:RoomObjectTileMouseEvent = param1 as RoomObjectTileMouseEvent;
         var _loc9_:RoomObjectWallMouseEvent = param1 as RoomObjectWallMouseEvent;
         if(_loc6_ == null)
         {
            if(_loc5_.category == RoomObjectCategoryEnum.const_35 && _loc8_ != null)
            {
               _loc7_ = _roomEngine.addObjectFurniture(param2,param3,_loc5_.id,_loc5_.typeId,new Vector3d(),new Vector3d(),0,null);
            }
            else if(_loc5_.category == RoomObjectCategoryEnum.const_28 && _loc9_ != null)
            {
               _loc7_ = _roomEngine.addObjectWallItem(param2,param3,_loc5_.id,_loc5_.typeId,new Vector3d(),new Vector3d(),0,_loc5_.instanceData);
            }
            _loc6_ = _roomEngine.getRoomObject(param2,param3,_loc5_.id,_loc5_.category) as IRoomObjectController;
            if(_loc5_.category == RoomObjectCategoryEnum.const_35)
            {
               if(_loc6_ != null)
               {
                  if(_loc6_.getModel() != null)
                  {
                     _loc10_ = _loc6_.getModel().getNumberArray(RoomObjectVariableEnum.const_686);
                     if(_loc10_ != null && _loc10_.length > 0)
                     {
                        _loc11_ = new Vector3d(_loc10_[0]);
                        _loc6_.setDirection(_loc11_);
                        updateSelectedObjectData(param2,param3,_loc5_.id,_loc5_.category,_loc5_.loc,_loc11_,_loc5_.operation,_loc5_.typeId);
                        _loc5_ = getSelectedObjectData(param2,param3);
                        if(_loc5_ == null)
                        {
                           return;
                        }
                     }
                  }
               }
            }
            setObjectAlphaMultiplier(_loc6_,0.5);
            _roomEngine.setObjectMoverIconSpriteVisible(true);
         }
         if(_loc6_ != null)
         {
            _loc12_ = true;
            if(_loc5_.category == RoomObjectCategoryEnum.const_35)
            {
               _loc13_ = _roomEngine.getTileHeightMap(param2,param3);
               if(!(_loc8_ != null && handleFurnitureMove(_loc6_,_loc5_,_loc8_.tileX + 0.5,_loc8_.tileY + 0.5,_loc13_)))
               {
                  _roomEngine.disposeObjectFurniture(param2,param3,_loc5_.id);
                  _loc12_ = false;
               }
            }
            else if(_loc5_.category == RoomObjectCategoryEnum.const_28)
            {
               _loc12_ = false;
               if(_loc9_ != null)
               {
                  _loc14_ = _loc9_.wallLocation;
                  _loc15_ = _loc9_.wallWidth;
                  _loc16_ = _loc9_.wallHeight;
                  _loc17_ = _loc9_.x;
                  _loc18_ = _loc9_.y;
                  _loc19_ = _loc9_.direction;
                  if(handleWallItemMove(_loc6_,_loc5_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_,_loc19_))
                  {
                     _loc12_ = true;
                  }
               }
               if(!_loc12_)
               {
                  _roomEngine.disposeObjectWallItem(param2,param3,_loc5_.id);
               }
               _roomEngine.updateObjectRoomWindow(param2,param3,_loc5_.id,_loc12_);
            }
            _roomEngine.setObjectMoverIconSpriteVisible(!_loc12_);
         }
      }
      
      private function changeObjectState(param1:int, param2:int, param3:int, param4:String, param5:int, param6:Boolean) : void
      {
         var _loc7_:int = 0;
         if(_roomEngine != null && false)
         {
            _loc7_ = _roomEngine.getRoomObjectCategory(param4);
            if(_loc7_ == RoomObjectCategoryEnum.const_35)
            {
               if(!param6)
               {
                  _roomEngine.connection.send(new UseFurnitureMessageComposer(param3,param5));
               }
               else
               {
                  _roomEngine.connection.send(new SetRandomStateMessageComposer(param3,param5));
               }
            }
            else if(_loc7_ == RoomObjectCategoryEnum.const_28)
            {
               _roomEngine.connection.send(new UseWallItemMessageComposer(param3,param5));
            }
         }
      }
      
      private function handleRoomObjectMouseClick(param1:RoomObjectMouseEvent, param2:int, param3:int) : void
      {
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:String = "null";
         var _loc5_:SelectedRoomObjectData = getSelectedObjectData(param2,param3);
         if(_loc5_ != null)
         {
            _loc4_ = _loc5_.operation;
         }
         var _loc6_:int = param1.objectId;
         var _loc7_:String = param1.objectType;
         var _loc8_:int = _roomEngine.getRoomObjectCategory(_loc7_);
         var _loc9_:int = _loc8_;
         var _loc10_:String = var_276.getValue(RoomObjectCategoryEnum.const_191);
         switch(_loc4_)
         {
            case RoomObjectOperationEnum.OBJECT_MOVE:
               if(_loc8_ == RoomObjectCategoryEnum.const_49)
               {
                  if(_loc5_ != null)
                  {
                     modifyRoomObject(param2,param3,_loc5_.id,_loc5_.category,RoomObjectOperationEnum.OBJECT_MOVE_TO);
                  }
               }
               break;
            case RoomObjectOperationEnum.OBJECT_PLACE:
               if(_loc8_ == RoomObjectCategoryEnum.const_49)
               {
                  placeObject(param2,param3);
               }
               break;
            case RoomObjectOperationEnum.OBJECT_UNDEFINED:
               if(_loc8_ == RoomObjectCategoryEnum.const_49)
               {
                  _loc11_ = param1 as RoomObjectTileMouseEvent;
                  if(_loc11_ != null)
                  {
                     walkTo(_loc11_.tileX + 0.499,_loc11_.tileY + 0.499);
                  }
               }
               else
               {
                  setSelectedObject(param2,param3,_loc6_,_loc8_);
                  if(_loc8_ == RoomObjectCategoryEnum.const_42)
                  {
                     if(_loc10_ != null)
                     {
                        var_276.remove(RoomObjectCategoryEnum.const_49);
                        var_276.add(RoomObjectCategoryEnum.const_49,_loc10_);
                     }
                  }
               }
         }
         if(_loc8_ == RoomObjectCategoryEnum.const_49)
         {
            _loc12_ = var_276.getValue(RoomObjectCategoryEnum.const_49) as String;
            if(_loc12_ != _loc10_)
            {
               _loc13_ = _roomEngine.events;
               if(_loc13_ != null)
               {
                  _loc13_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.const_390,param2,param3,-1,RoomObjectCategoryEnum.const_191));
               }
               setSelectedAvatar(param2,param3,0,false);
            }
         }
      }
      
      public function deleteWallItem(param1:int, param2:int, param3:int) : Boolean
      {
         if(_roomEngine == null || true)
         {
            return false;
         }
         _roomEngine.connection.send(new RemoveItemMessageComposer(param3,param1,param2));
         return true;
      }
      
      private function handleRoomObjectMouseDown(param1:RoomObjectMouseEvent, param2:int, param3:int) : void
      {
         var _loc10_:* = null;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:String = "null";
         var _loc5_:SelectedRoomObjectData = getSelectedObjectData(param2,param3);
         if(_loc5_ != null)
         {
            _loc4_ = _loc5_.operation;
         }
         var _loc6_:int = param1.objectId;
         var _loc7_:String = param1.objectType;
         var _loc8_:int = _roomEngine.getRoomObjectCategory(_loc7_);
         var _loc9_:int = _loc8_;
         switch(_loc4_)
         {
            case RoomObjectOperationEnum.OBJECT_UNDEFINED:
               if(_loc8_ != RoomObjectCategoryEnum.const_49)
               {
                  if(param1.altKey)
                  {
                     _loc10_ = _roomEngine.events;
                     if(_loc10_ != null)
                     {
                        _loc10_.dispatchEvent(new RoomEngineObjectEvent(RoomEngineObjectEvent.const_602,param2,param3,_loc6_,_loc8_));
                     }
                  }
                  else
                  {
                     setSelectedObject(param2,param3,_loc6_,_loc8_);
                  }
               }
         }
      }
      
      private function validateFurnitureLocation(param1:IRoomObject, param2:IVector3d, param3:IVector3d, param4:IVector3d, param5:TileHeightMap) : Vector3d
      {
         var _loc15_:* = null;
         if(param1 == null || param1.getModel() == null || param2 == null)
         {
            return null;
         }
         var _loc6_:IVector3d = param1.getDirection();
         if(_loc6_ == null)
         {
            return null;
         }
         if(param3 == null || param4 == null)
         {
            return null;
         }
         if(param2.x == param3.x && param2.y == param3.y)
         {
            if(_loc6_.x == param4.x)
            {
               _loc15_ = new Vector3d();
               _loc15_.assign(param3);
               return _loc15_;
            }
         }
         var _loc7_:int = param1.getModel().getNumber(RoomObjectVariableEnum.const_424);
         var _loc8_:int = param1.getModel().getNumber(RoomObjectVariableEnum.const_635);
         if(_loc7_ < 1)
         {
            _loc7_ = 1;
         }
         if(_loc8_ < 1)
         {
            _loc8_ = 1;
         }
         var _loc9_:int = param3.x;
         var _loc10_:int = param3.y;
         var _loc11_:int = _loc7_;
         var _loc12_:int = _loc8_;
         var _loc13_:int = 0;
         var _loc14_:int = int(_loc6_.x + 45) % 360 / 90;
         if(_loc14_ == 1 || _loc14_ == 3)
         {
            _loc13_ = _loc7_;
            _loc7_ = _loc8_;
            _loc8_ = _loc13_;
         }
         _loc14_ = int(param4.x + 45) % 360 / 90;
         if(_loc14_ == 1 || _loc14_ == 3)
         {
            _loc13_ = _loc11_;
            _loc11_ = _loc12_;
            _loc12_ = _loc13_;
         }
         if(param5 != null && param2 != null)
         {
            if(param5.validateLocation(param2.x,param2.y,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_))
            {
               return new Vector3d(param2.x,param2.y,param5.getTileHeight(param2.x,param2.y));
            }
            return null;
         }
         return null;
      }
      
      public function modifyRoomObject(param1:int, param2:int, param3:int, param4:int, param5:String) : Boolean
      {
         var _loc11_:* = null;
         var _loc12_:* = null;
         if(_roomEngine == null)
         {
            return false;
         }
         var _loc6_:IRoomObjectController = _roomEngine.getRoomObject(param1,param2,param3,param4) as IRoomObjectController;
         if(_loc6_ == null)
         {
            return false;
         }
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Boolean = true;
         switch(param5)
         {
            case RoomObjectOperationEnum.OBJECT_ROTATE_POSITIVE:
            case RoomObjectOperationEnum.OBJECT_ROTATE_NEGATIVE:
               if(false)
               {
                  if(param5 == RoomObjectOperationEnum.OBJECT_ROTATE_NEGATIVE)
                  {
                     _loc9_ = getValidFurnitureDirection(_loc6_,false);
                  }
                  else
                  {
                     _loc9_ = getValidFurnitureDirection(_loc6_,true);
                  }
                  _loc7_ = _loc6_.getLocation().x;
                  _loc8_ = _loc6_.getLocation().y;
                  if(validateFurnitureDirection(_loc6_,new Vector3d(_loc9_),_roomEngine.getTileHeightMap(param1,param2)))
                  {
                     _loc9_ = int(_loc9_ / 45);
                     _roomEngine.connection.send(new MoveObjectMessageComposer(param3,_loc7_,_loc8_,_loc9_));
                  }
               }
               break;
            case RoomObjectOperationEnum.OBJECT_PICKUP:
               if(false)
               {
                  _roomEngine.connection.send(new PickupObjectMessageComposer(param3,param4));
               }
               break;
            case RoomObjectOperationEnum.OBJECT_MOVE:
               _loc10_ = false;
               setObjectAlphaMultiplier(_loc6_,0.5);
               setSelectedObjectData(param1,param2,_loc6_.getId(),param4,_loc6_.getLocation(),_loc6_.getDirection(),param5);
               _roomEngine.setObjectMoverIconSprite(_loc6_.getId(),param4,true);
               _roomEngine.setObjectMoverIconSpriteVisible(false);
               break;
            case RoomObjectOperationEnum.OBJECT_MOVE_TO:
               setObjectAlphaMultiplier(_loc6_,1);
               _roomEngine.removeObjectMoverIconSprite();
               if(false)
               {
                  if(param4 == RoomObjectCategoryEnum.const_35)
                  {
                     _loc9_ = int(_loc6_.getDirection().x) % 360;
                     _loc7_ = _loc6_.getLocation().x;
                     _loc8_ = _loc6_.getLocation().y;
                     _loc9_ = int(_loc9_ / 45);
                     _roomEngine.connection.send(new MoveObjectMessageComposer(param3,_loc7_,_loc8_,_loc9_));
                  }
                  else if(param4 == RoomObjectCategoryEnum.const_28)
                  {
                     _loc9_ = int(_loc6_.getDirection().x) % 360;
                     _loc11_ = _roomEngine.getLegacyGeometry(param1,param2);
                     if(false && _loc11_)
                     {
                        _loc12_ = _loc11_.getOldLocationString(_loc6_.getLocation(),_loc9_);
                        if(_loc12_ != null)
                        {
                           _roomEngine.connection.send(new PickupObjectMessageComposer(param3,param4));
                           _roomEngine.connection.send(new PlaceObjectMessageComposer(param3,RoomObjectCategoryEnum.const_28,_loc12_,0,0,0));
                        }
                     }
                  }
               }
         }
         if(_loc10_)
         {
            resetSelectedObjectData(param1,param2);
         }
         return true;
      }
      
      private function handleObjectRoomAdEvent(param1:RoomObjectEvent, param2:int, param3:int) : void
      {
         var _loc7_:* = null;
         if(_roomEngine == null || true || param1 == null)
         {
            return;
         }
         var _loc4_:int = param1.objectId;
         var _loc5_:String = param1.objectType;
         var _loc6_:int = _roomEngine.getRoomObjectCategory(_loc5_);
         switch(param1.type)
         {
            case RoomObjectRoomAdEvent.const_306:
               _loc7_ = "null";
               break;
            case RoomObjectRoomAdEvent.const_267:
               _loc7_ = "null";
         }
         if(_loc7_ == null)
         {
            return;
         }
         _roomEngine.events.dispatchEvent(new RoomEngineObjectEvent(_loc7_,param2,param3,_loc4_,_loc6_));
      }
      
      public function setSelectedAvatar(param1:int, param2:int, param3:int, param4:Boolean) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         var _loc5_:int = 0;
         var _loc6_:IRoomObjectController = _roomEngine.getRoomObject(param1,param2,var_899,_loc5_) as IRoomObjectController;
         if(_loc6_ != null && _loc6_.getEventHandler() != null)
         {
            _loc6_.getEventHandler().processUpdateMessage(new RoomObjectAvatarSelectedMessage(false));
            var_899 = -1;
         }
         var _loc7_:Boolean = false;
         if(param4)
         {
            _loc6_ = _roomEngine.getRoomObject(param1,param2,param3,_loc5_) as IRoomObjectController;
            if(_loc6_ != null && _loc6_.getEventHandler() != null)
            {
               _loc6_.getEventHandler().processUpdateMessage(new RoomObjectAvatarSelectedMessage(true));
               _loc7_ = true;
               var_899 = param3;
               _roomEngine.connection.send(new LookToMessageComposer(_loc6_.getLocation().x,_loc6_.getLocation().y));
            }
         }
         var _loc8_:IRoomObjectController = _roomEngine.getSelectionArrow(param1,param2);
         if(_loc8_ != null && _loc8_.getEventHandler() != null)
         {
            if(_loc7_)
            {
               _loc8_.getEventHandler().processUpdateMessage(new RoomObjectVisibilityUpdateMessage(RoomObjectVisibilityUpdateMessage.const_343));
            }
            else
            {
               _loc8_.getEventHandler().processUpdateMessage(new RoomObjectVisibilityUpdateMessage(RoomObjectVisibilityUpdateMessage.const_415));
            }
         }
      }
      
      private function handleRoomObjectMouseEvent(param1:RoomObjectMouseEvent, param2:int, param3:int) : void
      {
         switch(param1.type)
         {
            case RoomObjectMouseEvent.const_180:
               handleRoomObjectMouseClick(param1,param2,param3);
               break;
            case RoomObjectMouseEvent.const_451:
               handleRoomObjectMouseMove(param1,param2,param3);
               break;
            case RoomObjectMouseEvent.const_334:
               handleRoomObjectMouseDown(param1,param2,param3);
         }
      }
      
      private function handleRoomActionEvent(param1:RoomObjectEvent, param2:int, param3:int) : void
      {
         var _loc4_:* = null;
         if(param1 == null)
         {
            return;
         }
         if(_roomEngine != null && false)
         {
            switch(param1.type)
            {
               case RoomObjectRoomActionEvent.const_438:
                  _loc4_ = param1 as RoomObjectRoomActionEvent;
                  if(_loc4_ != null)
                  {
                     _roomEngine.connection.send(new ChangeRoomMessageComposer(_loc4_.param));
                  }
                  break;
               case RoomObjectRoomActionEvent.const_416:
                  _roomEngine.connection.send(new TryBusMessageComposer());
            }
         }
      }
      
      private function handleObjectInitializeEvent(param1:RoomObjectEvent, param2:int, param3:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         initializeObject(param2,param3,param1.objectId,param1.objectType,param1.type);
      }
      
      private function validateFurnitureDirection(param1:IRoomObject, param2:IVector3d, param3:TileHeightMap) : Boolean
      {
         if(param1 == null || param1.getModel() == null || param2 == null)
         {
            return false;
         }
         var _loc4_:IVector3d = param1.getDirection();
         var _loc5_:IVector3d = param1.getLocation();
         if(_loc4_ == null || _loc5_ == null)
         {
            return false;
         }
         if(_loc4_.x % 180 == param2.x % 180)
         {
            return true;
         }
         var _loc6_:int = param1.getModel().getNumber(RoomObjectVariableEnum.const_424);
         var _loc7_:int = param1.getModel().getNumber(RoomObjectVariableEnum.const_635);
         if(_loc6_ < 1)
         {
            _loc6_ = 1;
         }
         if(_loc7_ < 1)
         {
            _loc7_ = 1;
         }
         var _loc8_:int = _loc6_;
         var _loc9_:int = _loc7_;
         var _loc10_:int = 0;
         var _loc11_:int = int(param2.x + 45) % 360 / 90;
         if(_loc11_ == 1 || _loc11_ == 3)
         {
            _loc10_ = _loc6_;
            _loc6_ = _loc7_;
            _loc7_ = _loc10_;
         }
         _loc11_ = int(_loc4_.x + 45) % 360 / 90;
         if(_loc11_ == 1 || _loc11_ == 3)
         {
            _loc10_ = _loc8_;
            _loc8_ = _loc9_;
            _loc9_ = _loc10_;
         }
         if(param3 != null && _loc5_ != null)
         {
            if(param3.validateLocation(_loc5_.x,_loc5_.y,_loc6_,_loc7_,_loc5_.x,_loc5_.y,_loc8_,_loc9_))
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function cancelRoomObjectInsert(param1:int, param2:int) : Boolean
      {
         resetSelectedObjectData(param1,param2);
         return true;
      }
      
      private function initializeObject(param1:int, param2:int, param3:int, param4:String, param5:String) : void
      {
      }
      
      private function handleSelectedObjectMove(param1:RoomObjectEvent, param2:int, param3:int) : void
      {
         var _loc9_:* = null;
         var _loc10_:* = null;
         if(_roomEngine == null)
         {
            return;
         }
         var _loc4_:int = param1.objectId;
         var _loc5_:String = param1.objectType;
         var _loc6_:int = _roomEngine.getRoomObjectCategory(_loc5_);
         var _loc7_:IRoomObjectController = _roomEngine.getRoomObject(param2,param3,_loc4_,_loc6_) as IRoomObjectController;
         var _loc8_:IRoomObjectController = _roomEngine.getSelectionArrow(param2,param3);
         if(_loc7_ != null && _loc8_ != null && _loc8_.getEventHandler() != null)
         {
            _loc9_ = _loc7_.getLocation();
            _loc10_ = new RoomObjectUpdateMessage(_loc9_,null);
            _loc8_.getEventHandler().processUpdateMessage(_loc10_);
         }
      }
      
      private function handleRoomObjectMouseMove(param1:RoomObjectMouseEvent, param2:int, param3:int) : void
      {
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:String = "null";
         var _loc5_:SelectedRoomObjectData = getSelectedObjectData(param2,param3);
         if(_loc5_ != null)
         {
            _loc4_ = _loc5_.operation;
         }
         var _loc6_:String = param1.objectType;
         var _loc7_:int = _roomEngine.getRoomObjectCategory(_loc6_);
         if(_roomEngine != null)
         {
            _loc8_ = _roomEngine.getTileCursor(param2,param3);
            if(_loc8_ != null && _loc8_.getEventHandler() != null)
            {
               _loc9_ = param1 as RoomObjectTileMouseEvent;
               _loc10_ = null;
               if(_loc9_ != null)
               {
                  _loc11_ = _loc9_.tileX + 0.499;
                  _loc12_ = _loc9_.tileY + 0.499;
                  _loc13_ = _loc9_.tileZ + 0.499;
                  _loc10_ = new RoomObjectUpdateMessage(new Vector3d(_loc11_,_loc12_,_loc13_),null);
                  _loc8_.getEventHandler().processUpdateMessage(_loc10_);
                  _loc10_ = new RoomObjectVisibilityUpdateMessage(RoomObjectVisibilityUpdateMessage.const_343);
               }
               else
               {
                  _loc10_ = new RoomObjectVisibilityUpdateMessage(RoomObjectVisibilityUpdateMessage.const_415);
               }
               _loc8_.getEventHandler().processUpdateMessage(_loc10_);
            }
         }
         switch(_loc4_)
         {
            case RoomObjectOperationEnum.OBJECT_MOVE:
               if(_loc7_ == RoomObjectCategoryEnum.const_49)
               {
                  handleObjectMove(param1,param2,param3);
               }
               break;
            case RoomObjectOperationEnum.OBJECT_PLACE:
               if(_loc7_ == RoomObjectCategoryEnum.const_49)
               {
                  handleObjectPlace(param1,param2,param3);
               }
         }
      }
      
      public function handleRoomObjectEvent(param1:RoomObjectEvent, param2:int, param3:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 is RoomObjectMouseEvent)
         {
            handleRoomObjectMouseEvent(param1 as RoomObjectMouseEvent,param2,param3);
            return;
         }
         switch(param1.type)
         {
            case RoomObjectStateChangeEvent.const_217:
               handleObjectStateChange(param1 as RoomObjectStateChangeEvent,param2,param3);
               break;
            case RoomObjectStateChangeEvent.ROOM_OBJECT_STATE_RANDOM:
               handleObjectRandomStateChange(param1 as RoomObjectStateChangeEvent,param2,param3);
               break;
            case RoomObjectDimmerStateUpdateEvent.const_60:
               handleObjectDimmerStateEvent(param1,param2,param3);
               break;
            case RoomObjectMoveEvent.POSITION_CHANGED:
               handleSelectedObjectMove(param1,param2,param3);
               break;
            case RoomObjectMoveEvent.const_394:
               handleSelectedObjectRemove(param1,param2,param3);
               break;
            case RoomObjectWidgetRequestEvent.const_107:
            case RoomObjectWidgetRequestEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI:
            case RoomObjectWidgetRequestEvent.const_102:
            case RoomObjectWidgetRequestEvent.const_114:
            case RoomObjectWidgetRequestEvent.const_116:
            case RoomObjectWidgetRequestEvent.ROOM_OBJECT_WIDGET_REQUEST_ECOTRONBOX:
            case RoomObjectWidgetRequestEvent.const_104:
            case RoomObjectWidgetRequestEvent.const_82:
               handleObjectWidgetRequestEvent(param1,param2,param3);
               break;
            case RoomObjectFurnitureActionEvent.const_362:
            case RoomObjectFurnitureActionEvent.const_363:
            case RoomObjectFurnitureActionEvent.const_342:
            case RoomObjectFurnitureActionEvent.const_456:
            case RoomObjectFurnitureActionEvent.const_399:
               handleObjectActionEvent(param1,param2,param3);
               break;
            case RoomObjectFurnitureActionEvent.const_413:
            case RoomObjectFurnitureActionEvent.const_352:
            case RoomObjectFurnitureActionEvent.ROOM_OBJECT_SOUND_MACHINE_DISPOSE:
               handleObjectSoundMachineEvent(param1,param2,param3);
               break;
            case RoomObjectFurnitureActionEvent.const_335:
            case RoomObjectFurnitureActionEvent.const_457:
               handleObjectJukeboxEvent(param1,param2,param3);
               break;
            case RoomObjectRoomAdEvent.const_306:
            case RoomObjectRoomAdEvent.const_267:
               handleObjectRoomAdEvent(param1,param2,param3);
               break;
            case RoomObjectRoomActionEvent.const_438:
            case RoomObjectRoomActionEvent.const_827:
            case RoomObjectRoomActionEvent.const_416:
               handleRoomActionEvent(param1,param2,param3);
         }
      }
      
      private function getSelectedObjectData(param1:int, param2:int) : SelectedRoomObjectData
      {
         if(_roomEngine == null)
         {
            return null;
         }
         var _loc3_:ISelectedRoomObjectData = _roomEngine.getSelectedObjectData(param1,param2);
         return _loc3_ as SelectedRoomObjectData;
      }
      
      private function handleObjectSoundMachineEvent(param1:RoomObjectEvent, param2:int, param3:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         switch(param1.type)
         {
            case RoomObjectFurnitureActionEvent.const_413:
               _roomEngine.events.dispatchEvent(new RoomObjectSoundMachineStateUpdateEvent(param1.objectId,param1.objectType,RoomObjectSoundMachineStateUpdateEvent.const_832));
               break;
            case RoomObjectFurnitureActionEvent.const_352:
               _roomEngine.events.dispatchEvent(new RoomObjectSoundMachineStateUpdateEvent(param1.objectId,param1.objectType,RoomObjectSoundMachineStateUpdateEvent.const_1158));
               break;
            case RoomObjectFurnitureActionEvent.ROOM_OBJECT_SOUND_MACHINE_DISPOSE:
               _roomEngine.events.dispatchEvent(new RoomObjectSoundMachineStateUpdateEvent(param1.objectId,param1.objectType,RoomObjectSoundMachineStateUpdateEvent.const_752));
         }
      }
      
      private function handleObjectActionEvent(param1:RoomObjectEvent, param2:int, param3:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         useObject(param2,param3,param1.objectId,param1.objectType,param1.type);
      }
      
      public function processRoomCanvasMouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomObject, param3:String, param4:IRoomGeometry) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc5_:String = param2.getType();
         var _loc6_:int = _roomEngine.getRoomObjectCategory(_loc5_);
         if(_loc6_ != RoomObjectCategoryEnum.const_49)
         {
            _loc6_ = 0;
         }
         var _loc7_:String = var_276.getValue(_loc6_) as String;
         if(_loc7_ == param3)
         {
            if(param1.type == MouseEvent.CLICK || param1.type == MouseEvent.DOUBLE_CLICK || param1.type == MouseEvent.MOUSE_DOWN || param1.type == MouseEvent.MOUSE_UP || param1.type == MouseEvent.MOUSE_MOVE)
            {
               return;
            }
         }
         else
         {
            var_276.remove(_loc6_);
            var_276.add(_loc6_,param3);
         }
         if(param2.getMouseHandler() != null)
         {
            param2.getMouseHandler().mouseEvent(param1,param4);
         }
      }
      
      private function handleObjectMove(param1:RoomObjectMouseEvent, param2:int, param3:int) : void
      {
         var _loc7_:Boolean = false;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         if(param1 == null || _roomEngine == null)
         {
            return;
         }
         var _loc4_:IEventDispatcher = _roomEngine.events;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:SelectedRoomObjectData = getSelectedObjectData(param2,param3);
         if(_loc5_ == null)
         {
            return;
         }
         var _loc6_:IRoomObjectController = _roomEngine.getRoomObject(param2,param3,_loc5_.id,_loc5_.category) as IRoomObjectController;
         if(_loc6_ != null)
         {
            _loc7_ = true;
            if(_loc5_.category == RoomObjectCategoryEnum.const_35)
            {
               _loc8_ = _roomEngine.getTileHeightMap(param2,param3);
               _loc9_ = param1 as RoomObjectTileMouseEvent;
               if(!(_loc9_ != null && handleFurnitureMove(_loc6_,_loc5_,_loc9_.tileX + 0.5,_loc9_.tileY + 0.5,_loc8_)))
               {
                  handleFurnitureMove(_loc6_,_loc5_,_loc5_.loc.x,_loc5_.loc.y,_loc8_);
                  _loc7_ = false;
               }
            }
            else if(_loc5_.category == RoomObjectCategoryEnum.const_28)
            {
               _loc7_ = false;
               _loc10_ = param1 as RoomObjectWallMouseEvent;
               if(_loc10_ != null)
               {
                  _loc11_ = _loc10_.wallLocation;
                  _loc12_ = _loc10_.wallWidth;
                  _loc13_ = _loc10_.wallHeight;
                  _loc14_ = _loc10_.x;
                  _loc15_ = _loc10_.y;
                  _loc16_ = _loc10_.direction;
                  if(handleWallItemMove(_loc6_,_loc5_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_))
                  {
                     _loc7_ = true;
                  }
               }
               if(!_loc7_)
               {
                  _loc6_.setLocation(_loc5_.loc);
                  _loc6_.setDirection(_loc5_.dir);
               }
               _roomEngine.updateObjectRoomWindow(param2,param3,_loc5_.id,_loc7_);
            }
            if(_loc7_)
            {
               setObjectAlphaMultiplier(_loc6_,0.5);
               _roomEngine.setObjectMoverIconSpriteVisible(false);
            }
            else
            {
               setObjectAlphaMultiplier(_loc6_,0);
               _roomEngine.setObjectMoverIconSpriteVisible(true);
            }
         }
      }
   }
}
