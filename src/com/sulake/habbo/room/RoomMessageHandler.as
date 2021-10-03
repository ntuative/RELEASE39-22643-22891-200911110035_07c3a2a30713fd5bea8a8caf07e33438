package com.sulake.habbo.room
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.room.action.AvatarEffectMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.action.CarryObjectMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.action.DanceMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.action.SleepMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.action.UseObjectMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.action.WaveMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.chat.ChatMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.chat.ShoutMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.chat.UserTypingMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.chat.WhisperMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.AvatarActionMessageData;
   import com.sulake.habbo.communication.messages.incoming.room.engine.FloorHeightMapMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.FurnitureAliasesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.HeightMapMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.HeightMapUpdateMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ItemAddMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ItemDataUpdateMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ItemRemoveMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ItemUpdateMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ItemsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectAddMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectDataUpdateMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectUpdateMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.PublicRoomObjectMessageData;
   import com.sulake.habbo.communication.messages.incoming.room.engine.PublicRoomObjectsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomPropertyMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.SlideObjectBundleMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.SlideObjectMessageData;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserMessageData;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserRemoveMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserUpdateMessageData;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserUpdateMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UsersMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.DiceValueMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.OneWayDoorStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.publicroom.ParkBusDoorMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.GetFurnitureAliasesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.GetRoomEntryDataMessageComposer;
   import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.action.AvatarEffectMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.action.CarryObjectMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.action.DanceMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.action.SleepMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.action.UseObjectMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.action.WaveMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.chat.ChatMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.chat.UserTypingMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.FloorHeightMapMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.FurnitureAliasesMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.HeightMapMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.HeightMapUpdateMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.ItemAddMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.ItemDataUpdateMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.ItemRemoveMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.ItemUpdateMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.ItemsMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.ObjectAddMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.ObjectDataUpdateMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.ObjectRemoveMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.ObjectUpdateMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.ObjectsMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.PublicRoomObjectsMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomPropertyMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.SlideObjectBundleMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.UserRemoveMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.UserUpdateMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.UsersMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.furniture.DiceValueMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.furniture.OneWayDoorStatusMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.publicroom.ParkBusDoorMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.session.CloseConnectionMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;
   import com.sulake.habbo.room.messages.RoomObjectAvatarCarryObjectUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarChatUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarDanceUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarEffectUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarFlatControlUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarGestureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPetGestureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPostureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarSignUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarSleepUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarTypingUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarUseObjectUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarWaveUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomUpdateMessage;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.room.object.RoomPlaneParser;
   import com.sulake.habbo.room.utils.LegacyWallGeometry;
   import com.sulake.habbo.room.utils.TileHeightMap;
   import com.sulake.room.IRoomInstance;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomMessageHandler
   {
       
      
      private var var_24:IRoomCreator = null;
      
      private var var_853:int = -1000000000;
      
      private var var_1030:Boolean = true;
      
      private var var_81:RoomPlaneParser = null;
      
      private var var_1577:int = -1;
      
      private var _connection:IConnection = null;
      
      public function RoomMessageHandler(param1:IRoomCreator)
      {
         super();
         var_24 = param1;
         var_81 = new RoomPlaneParser();
         var_1030 = true;
      }
      
      private function onItemUpdate(param1:IMessageEvent) : void
      {
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc2_:ItemUpdateMessageEvent = param1 as ItemUpdateMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         var _loc3_:ItemUpdateMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:LegacyWallGeometry = var_24.getLegacyGeometry(_loc4_,_loc5_);
         if(var_24 == null || _loc6_ == null)
         {
            return;
         }
         var _loc7_:ItemMessageData = _loc3_.data;
         if(_loc7_ != null)
         {
            _loc8_ = _loc6_.getLocation(_loc7_.wallX,_loc7_.wallY,_loc7_.localX,_loc7_.localY,_loc7_.dir);
            _loc9_ = new Vector3d(_loc6_.getDirection(_loc7_.dir));
            var_24.updateObjectWallItem(_loc4_,_loc5_,_loc7_.id,_loc8_,_loc9_,_loc7_.state,_loc7_.data);
         }
      }
      
      private function onUseObject(param1:IMessageEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(var_24 == null)
         {
            return;
         }
         if(param1 is UseObjectMessageEvent)
         {
            _loc2_ = (param1 as UseObjectMessageEvent).getParser();
            _loc3_ = new RoomObjectAvatarUseObjectUpdateMessage(_loc2_.itemType);
            var_24.updateObjectUserState(_loc2_.roomId,_loc2_.roomCategory,_loc2_.userId,_loc3_);
         }
      }
      
      private function onDance(param1:IMessageEvent) : void
      {
         var _loc2_:DanceMessageEvent = param1 as DanceMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:DanceMessageParser = _loc2_.getParser();
         var _loc4_:RoomObjectAvatarDanceUpdateMessage = new RoomObjectAvatarDanceUpdateMessage(_loc3_.danceStyle);
         var_24.updateObjectUserState(_loc3_.roomId,_loc3_.roomCategory,_loc3_.userId,_loc4_);
      }
      
      private function onHeightMap(param1:IMessageEvent) : void
      {
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc2_:HeightMapMessageEvent = param1 as HeightMapMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:HeightMapMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:int = _loc3_.width;
         var _loc7_:int = _loc3_.height;
         var _loc8_:TileHeightMap = new TileHeightMap(_loc6_,_loc7_);
         var _loc9_:int = 0;
         while(_loc9_ < _loc7_)
         {
            _loc10_ = 0;
            while(_loc10_ < _loc6_)
            {
               _loc11_ = _loc3_.getTileHeight(_loc10_,_loc9_);
               _loc12_ = _loc3_.getTileBlocking(_loc10_,_loc9_);
               _loc13_ = _loc3_.isRoomTile(_loc10_,_loc9_);
               _loc8_.setTileHeight(_loc10_,_loc9_,_loc11_);
               _loc8_.setTileBlocking(_loc10_,_loc9_,_loc12_);
               _loc8_.setIsRoomTile(_loc10_,_loc9_,_loc13_);
               _loc10_++;
            }
            _loc9_++;
         }
         var_24.setTileHeightMap(_loc4_,_loc5_,_loc8_);
      }
      
      private function onUserChange(param1:IMessageEvent) : void
      {
         var _loc2_:UserChangeMessageEvent = param1 as UserChangeMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:RoomObjectAvatarFigureUpdateMessage = new RoomObjectAvatarFigureUpdateMessage(_loc2_.figure);
         var_24.updateObjectUserState(_loc2_.roomId,_loc2_.roomCategory,_loc2_.id,_loc3_);
      }
      
      public function dispose() : void
      {
         _connection = null;
         var_24 = null;
         if(var_81 != null)
         {
            var_81.dispose();
            var_81 = null;
         }
      }
      
      private function onItems(param1:IMessageEvent) : void
      {
         var _loc8_:* = null;
         var _loc2_:ItemsMessageEvent = param1 as ItemsMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         var _loc3_:ItemsMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:int = _loc3_.getItemCount();
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = _loc3_.getItem(_loc7_);
            addWallItem(_loc4_,_loc5_,_loc8_);
            _loc7_++;
         }
      }
      
      private function onObjectRemove(param1:IMessageEvent) : void
      {
         var _loc2_:ObjectRemoveMessageEvent = param1 as ObjectRemoveMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:ObjectRemoveMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:int = _loc3_.id;
         var_24.disposeObjectFurniture(_loc4_,_loc5_,_loc6_);
      }
      
      private function addPassiveObject(param1:int, param2:int, param3:PublicRoomObjectMessageData) : void
      {
         if(param3 == null || var_24 == null)
         {
            return;
         }
         var _loc4_:IVector3d = new Vector3d(param3.x,param3.y,param3.z);
         var _loc5_:IVector3d = new Vector3d(param3.dir);
         var _loc6_:int = getNextPassiveObjectId();
         var_24.addObjectFurnitureByName(param1,param2,_loc6_,param3.type,_loc4_,_loc5_,0,"");
      }
      
      private function onAvatarSleep(param1:IMessageEvent) : void
      {
         var _loc2_:SleepMessageEvent = param1 as SleepMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:SleepMessageParser = _loc2_.getParser();
         var _loc4_:RoomObjectAvatarSleepUpdateMessage = new RoomObjectAvatarSleepUpdateMessage(_loc3_.sleeping);
         var_24.updateObjectUserState(_loc3_.roomId,_loc3_.roomCategory,_loc3_.userId,_loc4_);
      }
      
      private function onOwnUserEvent(param1:IMessageEvent) : void
      {
         var _loc2_:UserObjectEvent = param1 as UserObjectEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:UserObjectMessageParser = _loc2_.getParser();
         if(_loc3_ != null)
         {
            var_1577 = _loc3_.id;
         }
      }
      
      private function onFurnitureAliases(param1:IMessageEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         if(var_24 != null)
         {
            _loc2_ = param1 as FurnitureAliasesMessageEvent;
            if(_loc2_ == null || _loc2_.getParser() == null)
            {
               return;
            }
            _loc3_ = _loc2_.getParser();
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.aliasCount;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc6_ = _loc3_.getName(_loc5_);
                  _loc7_ = _loc3_.getAlias(_loc5_);
                  var_24.setRoomObjectAlias(_loc6_,_loc7_);
                  _loc5_++;
               }
            }
         }
         param1.connection.send(new GetRoomEntryDataMessageComposer());
      }
      
      private function onParkBusDoor(param1:IMessageEvent) : void
      {
         var _loc2_:ParkBusDoorMessageEvent = param1 as ParkBusDoorMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:ParkBusDoorMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:IRoomObject = var_24.getObjectRoom(_loc4_,_loc5_);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc7_:IRoomObjectModelController = _loc6_.getModel() as IRoomObjectModelController;
         if(_loc7_ != null)
         {
            _loc7_.setNumber(RoomObjectVariableEnum.const_745,_loc3_.status);
         }
      }
      
      private function addActiveObject(param1:int, param2:int, param3:ObjectMessageData) : void
      {
         if(param3 == null || var_24 == null)
         {
            return;
         }
         var _loc4_:IVector3d = new Vector3d(param3.x,param3.y,param3.z);
         var _loc5_:IVector3d = new Vector3d(param3.dir);
         if(param3.staticClass != null)
         {
            var_24.addObjectFurnitureByName(param1,param2,param3.id,param3.staticClass,_loc4_,_loc5_,param3.state,param3.data);
         }
         else
         {
            var_24.addObjectFurniture(param1,param2,param3.id,param3.type,_loc4_,_loc5_,param3.state,param3.data);
         }
      }
      
      private function isPublicRoom(param1:int, param2:int) : Boolean
      {
         if(var_24)
         {
            return var_24.isPublicRoom(param1,param2);
         }
         return false;
      }
      
      private function onItemAdd(param1:IMessageEvent) : void
      {
         var _loc2_:ItemAddMessageEvent = param1 as ItemAddMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         var _loc3_:ItemAddMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:ItemMessageData = _loc3_.data;
         if(_loc6_ != null)
         {
            addWallItem(_loc4_,_loc5_,_loc6_);
         }
      }
      
      private function onObjectDataUpdate(param1:IMessageEvent) : void
      {
         var _loc2_:ObjectDataUpdateMessageEvent = param1 as ObjectDataUpdateMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:ObjectDataUpdateMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:int = _loc3_.id;
         var _loc7_:int = _loc3_.state;
         var _loc8_:String = _loc3_.data;
         var_24.updateObjectFurniture(_loc4_,_loc5_,_loc6_,null,null,_loc7_,_loc8_);
      }
      
      private function onObjects(param1:IMessageEvent) : void
      {
         var _loc8_:* = null;
         var _loc2_:ObjectsMessageEvent = param1 as ObjectsMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         var _loc3_:ObjectsMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:int = _loc3_.getObjectCount();
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = _loc3_.getObject(_loc7_);
            addActiveObject(_loc4_,_loc5_,_loc8_);
            _loc7_++;
         }
      }
      
      private function onItemRemove(param1:IMessageEvent) : void
      {
         var _loc2_:ItemRemoveMessageEvent = param1 as ItemRemoveMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:ItemRemoveMessageParser = _loc2_.getParser();
         var_24.disposeObjectWallItem(_loc3_.roomId,_loc3_.roomCategory,_loc3_.itemId);
      }
      
      private function onUserUpdate(param1:IMessageEvent) : void
      {
         var _loc9_:* = null;
         var _loc10_:Number = NaN;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc19_:* = null;
         var _loc20_:* = null;
         var _loc21_:* = null;
         var _loc22_:* = null;
         var _loc2_:UserUpdateMessageEvent = param1 as UserUpdateMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:UserUpdateMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:IRoomInstance = var_24.getRoom(_loc4_,_loc5_);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc7_:Number = _loc6_.getNumber(RoomVariableEnum.const_592);
         var _loc8_:int = 0;
         while(_loc8_ < _loc3_.userUpdateCount)
         {
            _loc9_ = _loc3_.getUserUpdateData(_loc8_);
            if(_loc9_ != null)
            {
               _loc10_ = _loc9_.localZ;
               if(_loc7_ != 0)
               {
                  _loc10_ /= _loc7_;
               }
               _loc11_ = new Vector3d(_loc9_.x,_loc9_.y,_loc9_.z + _loc10_);
               _loc12_ = new Vector3d(_loc9_.dir);
               _loc13_ = null;
               if(_loc9_.isMoving)
               {
                  _loc13_ = new Vector3d(_loc9_.targetX,_loc9_.targetY,_loc9_.targetZ);
               }
               var_24.updateObjectUser(_loc4_,_loc5_,_loc9_.id,_loc11_,_loc13_,_loc12_,_loc9_.dirHead);
               _loc14_ = "null";
               _loc15_ = "";
               _loc16_ = new RoomObjectAvatarFlatControlUpdateMessage(null);
               var_24.updateObjectUserState(_loc4_,_loc5_,_loc9_.id,_loc16_);
               _loc17_ = false;
               _loc18_ = false;
               for each(_loc19_ in _loc9_.actions)
               {
                  switch(_loc19_.actionType)
                  {
                     case "wav":
                     case "mv":
                        _loc18_ = true;
                     case "swim":
                        _loc17_ = true;
                        break;
                     case "std":
                     case "sit":
                     case "lay":
                     case "sml":
                     case "sad":
                     case "agr":
                     case "srp":
                     case "rdy":
                     case "ded":
                     case "jmp":
                     case "pla":
                     case "beg":
                     case "bnd":
                     case "eat":
                     case "snf":
                        break;
                     case "flatctrl":
                        _loc16_ = new RoomObjectAvatarFlatControlUpdateMessage(_loc19_.actionParameter);
                        var_24.updateObjectUserState(_loc4_,_loc5_,_loc9_.id,_loc16_);
                        continue;
                     case "sign":
                        _loc21_ = new RoomObjectAvatarSignUpdateMessage(int(_loc19_.actionParameter));
                        var_24.updateObjectUserState(_loc4_,_loc5_,_loc9_.id,_loc21_);
                        continue;
                     case "gst":
                        _loc22_ = new RoomObjectAvatarPetGestureUpdateMessage(_loc19_.actionParameter);
                        var_24.updateObjectUserState(_loc4_,_loc5_,_loc9_.id,_loc22_);
                        continue;
                     default:
                        Logger.log("[RoomMessageHandler] Unhandled status update actionType (Pets/Lido?): " + _loc19_.actionType);
                        continue;
                  }
                  _loc14_ = _loc19_.actionType;
                  _loc15_ = _loc19_.actionParameter;
               }
               if(!_loc18_ && _loc17_)
               {
                  _loc14_ = "float";
               }
               _loc20_ = new RoomObjectAvatarPostureUpdateMessage(_loc14_,_loc15_);
               var_24.updateObjectUserState(_loc4_,_loc5_,_loc9_.id,_loc20_);
            }
            _loc8_++;
         }
      }
      
      private function onRoomDisconnected(param1:IMessageEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(var_24 != null)
         {
            _loc2_ = param1 as CloseConnectionMessageEvent;
            _loc3_ = _loc2_.getParser();
            _loc4_ = _loc3_.roomId;
            _loc5_ = _loc3_.roomCategory;
            var_24.disposeRoom(_loc4_,_loc5_);
         }
      }
      
      private function addWallItem(param1:int, param2:int, param3:ItemMessageData) : void
      {
         if(param3 == null || var_24 == null)
         {
            return;
         }
         var _loc4_:LegacyWallGeometry = var_24.getLegacyGeometry(param1,param2);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:* = null;
         if(!param3.isOldFormat)
         {
            _loc5_ = _loc4_.getLocation(param3.wallX,param3.wallY,param3.localX,param3.localY,param3.dir);
         }
         else
         {
            _loc5_ = _loc4_.getLocationOldFormat(param3.y,param3.z,param3.dir);
         }
         var _loc6_:IVector3d = new Vector3d(_loc4_.getDirection(param3.dir));
         var_24.addObjectWallItem(param1,param2,param3.id,param3.type,_loc5_,_loc6_,param3.state,param3.data);
      }
      
      private function onItemDataUpdate(param1:IMessageEvent) : void
      {
         var _loc2_:ItemDataUpdateMessageEvent = param1 as ItemDataUpdateMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         var _loc3_:ItemDataUpdateMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var_24.updateObjectWallItemData(_loc4_,_loc5_,_loc3_.id,_loc3_.itemData);
      }
      
      private function onFloorHeightMap(param1:IMessageEvent) : void
      {
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:Boolean = false;
         var _loc23_:int = 0;
         var _loc24_:* = null;
         var _loc2_:FloorHeightMapMessageEvent = param1 as FloorHeightMapMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         var _loc3_:FloorHeightMapMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:LegacyWallGeometry = var_24.getLegacyGeometry(_loc4_,_loc5_);
         if(var_24 == null || _loc6_ == null)
         {
            return;
         }
         var_81.reset();
         var _loc7_:int = _loc3_.width;
         var _loc8_:int = _loc3_.height;
         var_81.initializeTileMap(_loc7_,_loc8_);
         var _loc9_:* = -1;
         var _loc10_:* = -1;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:Boolean = isPublicRoom(_loc4_,_loc5_);
         var _loc14_:TileHeightMap = var_24.getTileHeightMap(_loc4_,_loc5_);
         if(_loc14_ == null)
         {
            return;
         }
         var _loc15_:int = 0;
         while(_loc15_ < _loc8_)
         {
            _loc20_ = 0;
            while(_loc20_ < _loc7_)
            {
               _loc21_ = _loc3_.getTileHeight(_loc20_,_loc15_);
               if(!_loc13_)
               {
                  if((_loc15_ > 0 && _loc15_ < _loc8_ - 1 || _loc20_ > 0 && _loc20_ < _loc7_ - 1) && _loc21_ != RoomPlaneParser.TILE_BLOCKED)
                  {
                     if(_loc3_.getTileHeight(_loc20_,_loc15_ - 1) == RoomPlaneParser.TILE_BLOCKED && _loc3_.getTileHeight(_loc20_ - 1,_loc15_) == RoomPlaneParser.TILE_BLOCKED && _loc3_.getTileHeight(_loc20_,_loc15_ + 1) == RoomPlaneParser.TILE_BLOCKED)
                     {
                        _loc9_ = Number(_loc20_ + 0.5);
                        _loc10_ = Number(_loc15_);
                        _loc11_ = Number(_loc21_);
                        _loc12_ = 90;
                        if(!_loc14_.isRoomTile(_loc20_ + 1,_loc15_))
                        {
                           _loc9_ += 1;
                        }
                     }
                     if(_loc3_.getTileHeight(_loc20_,_loc15_ - 1) == RoomPlaneParser.TILE_BLOCKED && _loc3_.getTileHeight(_loc20_ - 1,_loc15_) == RoomPlaneParser.TILE_BLOCKED && _loc3_.getTileHeight(_loc20_ + 1,_loc15_) == RoomPlaneParser.TILE_BLOCKED)
                     {
                        _loc9_ = Number(_loc20_);
                        _loc10_ = Number(_loc15_ + 0.5);
                        _loc11_ = Number(_loc21_);
                        _loc12_ = 180;
                        if(!_loc14_.isRoomTile(_loc20_,_loc15_ + 1))
                        {
                           _loc10_ += 1;
                        }
                     }
                  }
               }
               _loc22_ = _loc14_.isRoomTile(_loc20_,_loc15_);
               if(!_loc22_)
               {
                  _loc21_ = 0;
               }
               var_81.setTileHeight(_loc20_,_loc15_,_loc21_);
               _loc20_++;
            }
            _loc15_++;
         }
         if(!_loc13_)
         {
            var_81.setTileHeight(Math.floor(_loc9_),Math.floor(_loc10_),_loc11_);
         }
         var _loc16_:* = _loc5_ == 1;
         if(_loc13_)
         {
            _loc16_ = true;
         }
         var_81.initializeFromTileData(_loc16_);
         if(!_loc13_)
         {
            var_81.setTileHeight(Math.floor(_loc9_),Math.floor(_loc10_),_loc11_ + var_81.wallHeight);
         }
         _loc6_.scale = _loc3_.scale;
         _loc6_.initialize(_loc7_,_loc8_,var_81.floorHeight);
         var _loc17_:int = _loc3_.height - 1;
         while(_loc17_ >= 0)
         {
            _loc23_ = _loc3_.width - 1;
            while(_loc23_ >= 0)
            {
               _loc6_.setTileHeight(_loc23_,_loc17_,var_81.getTileHeight(_loc23_,_loc17_));
               _loc23_--;
            }
            _loc17_--;
         }
         var _loc18_:XML = var_81.getXML();
         var _loc19_:XML = <dimensions minX="{var_81.minX}" maxX="{var_81.maxX}" minY="{var_81.minY}" maxY="{var_81.maxY}"/>;
         _loc18_.appendChild(_loc19_);
         if(!_loc13_)
         {
            _loc24_ = <doors><door x="{_loc9_}" y="{_loc10_}" z="{_loc11_}" dir="{_loc12_}"/></doors>;
            _loc18_.appendChild(_loc24_);
         }
         var_24.initializeRoom(_loc4_,_loc5_,_loc18_);
      }
      
      private function onAvatarEffect(param1:IMessageEvent) : void
      {
         var _loc2_:AvatarEffectMessageEvent = param1 as AvatarEffectMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:AvatarEffectMessageParser = _loc2_.getParser();
         var _loc4_:RoomObjectAvatarEffectUpdateMessage = new RoomObjectAvatarEffectUpdateMessage(_loc3_.effectId);
         var_24.updateObjectUserState(_loc3_.roomId,_loc3_.roomCategory,_loc3_.userId,_loc4_);
      }
      
      private function onObjectAdd(param1:IMessageEvent) : void
      {
         var _loc2_:ObjectAddMessageEvent = param1 as ObjectAddMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         var _loc3_:ObjectAddMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:ObjectMessageData = _loc3_.data;
         addActiveObject(_loc4_,_loc5_,_loc6_);
      }
      
      public function set connection(param1:IConnection) : void
      {
         if(_connection != null)
         {
            return;
         }
         if(param1 != null)
         {
            _connection = param1;
            param1.addMessageEvent(new UserObjectEvent(onOwnUserEvent));
            param1.addMessageEvent(new RoomReadyMessageEvent(onRoomReady));
            param1.addMessageEvent(new CloseConnectionMessageEvent(onRoomDisconnected));
            param1.addMessageEvent(new RoomPropertyMessageEvent(onRoomProperty));
            param1.addMessageEvent(new FloorHeightMapMessageEvent(onFloorHeightMap));
            param1.addMessageEvent(new HeightMapMessageEvent(onHeightMap));
            param1.addMessageEvent(new HeightMapUpdateMessageEvent(onHeightMapUpdate));
            param1.addMessageEvent(new FurnitureAliasesMessageEvent(onFurnitureAliases));
            param1.addMessageEvent(new ObjectsMessageEvent(onObjects));
            param1.addMessageEvent(new PublicRoomObjectsMessageEvent(onPublicRoomObjects));
            param1.addMessageEvent(new ObjectAddMessageEvent(onObjectAdd));
            param1.addMessageEvent(new ObjectUpdateMessageEvent(onObjectUpdate));
            param1.addMessageEvent(new ObjectDataUpdateMessageEvent(onObjectDataUpdate));
            param1.addMessageEvent(new ObjectRemoveMessageEvent(onObjectRemove));
            param1.addMessageEvent(new ItemsMessageEvent(onItems));
            param1.addMessageEvent(new ItemAddMessageEvent(onItemAdd));
            param1.addMessageEvent(new ItemRemoveMessageEvent(onItemRemove));
            param1.addMessageEvent(new ItemUpdateMessageEvent(onItemUpdate));
            param1.addMessageEvent(new ItemDataUpdateMessageEvent(onItemDataUpdate));
            param1.addMessageEvent(new UsersMessageEvent(onUsers));
            param1.addMessageEvent(new UserUpdateMessageEvent(onUserUpdate));
            param1.addMessageEvent(new UserRemoveMessageEvent(onUserRemove));
            param1.addMessageEvent(new UserChangeMessageEvent(onUserChange));
            param1.addMessageEvent(new WaveMessageEvent(onWave));
            param1.addMessageEvent(new DanceMessageEvent(onDance));
            param1.addMessageEvent(new AvatarEffectMessageEvent(onAvatarEffect));
            param1.addMessageEvent(new SleepMessageEvent(onAvatarSleep));
            param1.addMessageEvent(new CarryObjectMessageEvent(onCarryObject));
            param1.addMessageEvent(new UseObjectMessageEvent(onUseObject));
            param1.addMessageEvent(new SlideObjectBundleMessageEvent(onSlideUpdate));
            param1.addMessageEvent(new ChatMessageEvent(onChat));
            param1.addMessageEvent(new WhisperMessageEvent(onChat));
            param1.addMessageEvent(new ShoutMessageEvent(onChat));
            param1.addMessageEvent(new UserTypingMessageEvent(onTypingStatus));
            param1.addMessageEvent(new DiceValueMessageEvent(onDiceValue));
            param1.addMessageEvent(new OneWayDoorStatusMessageEvent(onOneWayDoorStatus));
            param1.addMessageEvent(new ParkBusDoorMessageEvent(onParkBusDoor));
         }
      }
      
      private function onRoomProperty(param1:IMessageEvent) : void
      {
         var _loc2_:RoomPropertyMessageEvent = param1 as RoomPropertyMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         var _loc3_:RoomPropertyMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc7_:String = _loc3_.floorType;
         var _loc8_:String = _loc3_.wallType;
         var _loc9_:String = _loc3_.landscapeType;
         if(var_24 != null)
         {
            var_24.updateObjectRoom(_loc4_,_loc5_,_loc7_,_loc8_,_loc9_);
         }
      }
      
      private function onChat(param1:IMessageEvent) : void
      {
         var _loc2_:* = null;
         if(var_24 == null)
         {
            return;
         }
         if(param1 is ChatMessageEvent)
         {
            _loc2_ = (param1 as ChatMessageEvent).getParser();
         }
         else if(param1 is WhisperMessageEvent)
         {
            _loc2_ = (param1 as WhisperMessageEvent).getParser();
         }
         else if(param1 is ShoutMessageEvent)
         {
            _loc2_ = (param1 as ShoutMessageEvent).getParser();
         }
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:RoomObjectAvatarGestureUpdateMessage = new RoomObjectAvatarGestureUpdateMessage(_loc2_.gesture);
         var_24.updateObjectUserState(_loc2_.roomId,_loc2_.roomCategory,_loc2_.userId,_loc3_);
         var _loc4_:RoomObjectAvatarChatUpdateMessage = new RoomObjectAvatarChatUpdateMessage(Math.ceil(_loc2_.text.length / 10));
         var_24.updateObjectUserState(_loc2_.roomId,_loc2_.roomCategory,_loc2_.userId,_loc4_);
      }
      
      private function getNextPassiveObjectId() : int
      {
         if(var_853 > 0)
         {
            var_853 = -1000000000;
         }
         return --var_853;
      }
      
      private function onCarryObject(param1:IMessageEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(var_24 == null)
         {
            return;
         }
         if(param1 is CarryObjectMessageEvent)
         {
            _loc2_ = (param1 as CarryObjectMessageEvent).getParser();
            _loc3_ = new RoomObjectAvatarCarryObjectUpdateMessage(_loc2_.itemType,_loc2_.itemName);
            var_24.updateObjectUserState(_loc2_.roomId,_loc2_.roomCategory,_loc2_.userId,_loc3_);
         }
      }
      
      private function onTypingStatus(param1:IMessageEvent) : void
      {
         var _loc2_:UserTypingMessageEvent = param1 as UserTypingMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:UserTypingMessageParser = _loc2_.getParser();
         var _loc4_:RoomObjectAvatarTypingUpdateMessage = new RoomObjectAvatarTypingUpdateMessage(_loc3_.isTyping);
         var_24.updateObjectUserState(_loc3_.roomId,_loc3_.roomCategory,_loc3_.userId,_loc4_);
      }
      
      private function onObjectUpdate(param1:IMessageEvent) : void
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc2_:ObjectUpdateMessageEvent = param1 as ObjectUpdateMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:ObjectUpdateMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:ObjectMessageData = _loc3_.data;
         if(_loc6_ != null)
         {
            _loc7_ = new Vector3d(_loc6_.x,_loc6_.y,_loc6_.z);
            _loc8_ = new Vector3d(_loc6_.dir);
            var_24.updateObjectFurniture(_loc4_,_loc5_,_loc6_.id,_loc7_,_loc8_,_loc6_.state,_loc6_.data);
         }
      }
      
      private function onRoomReady(param1:IMessageEvent) : void
      {
         if(var_24 != null)
         {
            var_24.disposeRoom(1,1);
         }
         var _loc2_:RoomReadyMessageEvent = param1 as RoomReadyMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null || param1.connection == null)
         {
            return;
         }
         var _loc3_:RoomReadyMessageParser = _loc2_.getParser();
         var _loc4_:String = _loc3_.roomType;
         if(var_24 != null)
         {
            var_24.setWorldType(_loc3_.roomId,_loc3_.roomCategory,_loc4_);
         }
         if(var_1030)
         {
            param1.connection.send(new GetFurnitureAliasesMessageComposer());
            var_1030 = false;
         }
         else
         {
            param1.connection.send(new GetRoomEntryDataMessageComposer());
         }
      }
      
      private function onOneWayDoorStatus(param1:IMessageEvent) : void
      {
         var _loc2_:OneWayDoorStatusMessageEvent = param1 as OneWayDoorStatusMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:OneWayDoorStatusMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:int = _loc3_.id;
         var _loc7_:int = _loc3_.status;
         var_24.updateObjectFurniture(_loc4_,_loc5_,_loc6_,null,null,_loc7_,"");
      }
      
      private function onDiceValue(param1:IMessageEvent) : void
      {
         var _loc2_:DiceValueMessageEvent = param1 as DiceValueMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:DiceValueMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:int = _loc3_.id;
         var _loc7_:int = _loc3_.value;
         var_24.updateObjectFurniture(_loc4_,_loc5_,_loc6_,null,null,_loc7_,"");
      }
      
      private function onUserRemove(param1:IMessageEvent) : void
      {
         var _loc2_:UserRemoveMessageEvent = param1 as UserRemoveMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:UserRemoveMessageParser = _loc2_.getParser();
         var_24.disposeObjectUser(_loc3_.roomId,_loc3_.roomCategory,_loc3_.id);
      }
      
      private function onUsers(param1:IMessageEvent) : void
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc2_:UsersMessageEvent = param1 as UsersMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:UsersMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_.getUserCount())
         {
            _loc7_ = _loc3_.getUser(_loc6_);
            if(_loc7_ != null)
            {
               _loc8_ = new Vector3d(_loc7_.x,_loc7_.y,_loc7_.z);
               _loc9_ = new Vector3d(_loc7_.dir);
               var_24.addObjectUser(_loc4_,_loc5_,_loc7_.id,_loc8_,_loc9_,_loc7_.dir,_loc7_.type);
               if(_loc7_.webID == var_1577)
               {
                  var_24.setOwnUserId(_loc4_,_loc5_,_loc7_.id);
               }
               _loc10_ = new RoomObjectAvatarFigureUpdateMessage(_loc7_.figure,_loc7_.race);
               var_24.updateObjectUserState(_loc4_,_loc5_,_loc7_.id,_loc10_);
            }
            _loc6_++;
         }
      }
      
      private function onPublicRoomObjects(param1:IMessageEvent) : void
      {
         var _loc8_:* = null;
         var _loc2_:PublicRoomObjectsMessageEvent = param1 as PublicRoomObjectsMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         var _loc3_:PublicRoomObjectsMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:int = _loc3_.getObjectCount();
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = _loc3_.getObject(_loc7_);
            addPassiveObject(_loc4_,_loc5_,_loc8_);
            _loc7_++;
         }
      }
      
      private function onWave(param1:IMessageEvent) : void
      {
         var _loc2_:WaveMessageEvent = param1 as WaveMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:WaveMessageParser = _loc2_.getParser();
         var _loc4_:RoomObjectAvatarWaveUpdateMessage = new RoomObjectAvatarWaveUpdateMessage(_loc3_.isWaving);
         var_24.updateObjectUserState(_loc3_.roomId,_loc3_.roomCategory,_loc3_.userId,_loc4_);
      }
      
      private function onSlideUpdate(param1:IMessageEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         if(var_24 == null)
         {
            return;
         }
         if(param1 is SlideObjectBundleMessageEvent)
         {
            _loc2_ = (param1 as SlideObjectBundleMessageEvent).getParser();
            _loc3_ = _loc2_.roomId;
            _loc4_ = _loc2_.roomCategory;
            var_24.updateObjectFurniture(_loc3_,_loc4_,_loc2_.id,null,null,1,null);
            var_24.updateObjectFurniture(_loc3_,_loc4_,_loc2_.id,null,null,2,null);
            _loc5_ = _loc2_.objectList;
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               _loc8_ = _loc5_[_loc7_];
               if(_loc8_ != null)
               {
                  _loc6_ = new RoomObjectMoveUpdateMessage(_loc8_.loc,_loc8_.target,null);
                  var_24.updateObjectFurnitureLocation(_loc3_,_loc4_,_loc8_.id,_loc6_ as RoomObjectUpdateMessage);
               }
               _loc7_++;
            }
            if(_loc2_.avatar != null)
            {
               _loc9_ = _loc2_.avatar;
               var_24.updateObjectUser(_loc3_,_loc4_,_loc9_.id,_loc9_.loc,_loc9_.target);
               switch(_loc9_.moveType)
               {
                  case SlideObjectMessageData.const_770:
                     _loc10_ = "mv";
                     break;
                  case SlideObjectMessageData.const_899:
                     _loc10_ = "std";
               }
               _loc11_ = new RoomObjectAvatarPostureUpdateMessage(_loc10_);
               var_24.updateObjectUserState(_loc3_,_loc4_,_loc9_.id,_loc11_);
            }
         }
      }
      
      private function onHeightMapUpdate(param1:IMessageEvent) : void
      {
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Boolean = false;
         var _loc2_:HeightMapUpdateMessageEvent = param1 as HeightMapUpdateMessageEvent;
         if(_loc2_ == null || _loc2_.getParser() == null)
         {
            return;
         }
         if(var_24 == null)
         {
            return;
         }
         var _loc3_:HeightMapUpdateMessageParser = _loc2_.getParser();
         var _loc4_:int = _loc3_.roomId;
         var _loc5_:int = _loc3_.roomCategory;
         var _loc6_:TileHeightMap = var_24.getTileHeightMap(_loc4_,_loc5_);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc7_:int = _loc6_.mapWidth;
         var _loc8_:int = _loc6_.mapHeight;
         var _loc9_:int = 0;
         while(_loc9_ < _loc8_)
         {
            _loc10_ = 0;
            while(_loc10_ < _loc7_)
            {
               _loc11_ = _loc6_.getTileHeight(_loc10_,_loc9_);
               _loc11_ = _loc3_.getTileHeight(_loc10_,_loc9_,_loc11_,_loc7_,_loc8_);
               _loc12_ = _loc6_.getTileBlocking(_loc10_,_loc9_);
               _loc12_ = _loc3_.getTileBlocking(_loc10_,_loc9_,_loc12_,_loc7_,_loc8_);
               _loc6_.setTileHeight(_loc10_,_loc9_,_loc11_);
               _loc6_.setTileBlocking(_loc10_,_loc9_,_loc12_);
               _loc10_++;
            }
            _loc9_++;
         }
      }
   }
}
