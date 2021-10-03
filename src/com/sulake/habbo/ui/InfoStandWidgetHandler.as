package com.sulake.habbo.ui
{
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.avatar.enum.AvatarType;
   import com.sulake.habbo.room.ImageResult;
   import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
   import com.sulake.habbo.room.object.RoomObjectOperationEnum;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.session.IPetInfo;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.session.events.RoomSessionPetInfoUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionUserBadgesEvent;
   import com.sulake.habbo.session.events.RoomSessionUserFigureUpdateEvent;
   import com.sulake.habbo.session.events.UserTagsReceivedEvent;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.widget.RoomWidgetEnum;
   import com.sulake.habbo.widget.events.RoomWidgetBadgeImageUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetChatInputContentUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetPetInfoUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserBadgesUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserFigureUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserTagsUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetFurniActionMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetGetBadgeDetailsMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRoomTagSearchMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class InfoStandWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var _isDisposed:Boolean = false;
      
      public function InfoStandWidgetHandler()
      {
         super();
      }
      
      private function onUserTags(param1:UserTagsReceivedEvent) : void
      {
         dispatchUserTags(param1.userId,param1.tags);
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         if(_container != null)
         {
            if(false)
            {
               _container.sessionDataManager.events.removeEventListener(UserTagsReceivedEvent.const_141,onUserTags);
               _container.sessionDataManager.events.removeEventListener(BadgeImageReadyEvent.BADGE_READY,onBadgeImage);
            }
            if(false)
            {
               _container.roomSessionManager.events.removeEventListener(RoomSessionUserFigureUpdateEvent.const_131,onFigureUpdate);
               _container.roomSessionManager.events.removeEventListener(RoomSessionPetInfoUpdateEvent.const_125,onPetInfo);
            }
         }
         _container = param1;
         if(param1 == null)
         {
            return;
         }
         if(false)
         {
            _container.sessionDataManager.events.addEventListener(UserTagsReceivedEvent.const_141,onUserTags);
            _container.sessionDataManager.events.addEventListener(BadgeImageReadyEvent.BADGE_READY,onBadgeImage);
         }
         if(false)
         {
            _container.roomSessionManager.events.addEventListener(RoomSessionUserFigureUpdateEvent.const_131,onFigureUpdate);
            _container.roomSessionManager.events.addEventListener(RoomSessionPetInfoUpdateEvent.const_125,onPetInfo);
         }
      }
      
      private function handleGetObjectInfoMessage(param1:RoomWidgetRoomObjectMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:* = null;
         var _loc21_:Boolean = false;
         var _loc22_:* = false;
         var _loc23_:Boolean = false;
         var _loc24_:int = 0;
         var _loc25_:* = null;
         var _loc26_:* = null;
         var _loc27_:int = 0;
         var _loc28_:* = null;
         var _loc29_:* = null;
         _loc2_ = _container.roomSession.roomId;
         _loc3_ = _container.roomSession.roomCategory;
         switch(param1.category)
         {
            case RoomObjectCategoryEnum.const_35:
            case RoomObjectCategoryEnum.const_28:
               if(true || true)
               {
                  return null;
               }
               if(param1.id < 0)
               {
                  return null;
               }
               _loc4_ = _container.roomEngine.getRoomObjectImage(_loc2_,_loc3_,param1.id,param1.category,new Vector3d(180),32,null);
               _loc5_ = new RoomWidgetFurniInfoUpdateEvent(RoomWidgetFurniInfoUpdateEvent.const_674);
               _loc5_.id = param1.id;
               _loc5_.category = param1.category;
               _loc6_ = _container.roomEngine.getRoomObject(_loc2_,_loc3_,param1.id,param1.category);
               if(_loc6_ == null || _loc6_.getModel() == null)
               {
                  return null;
               }
               _loc7_ = _loc6_.getType();
               if(_loc7_.indexOf("poster") == 0)
               {
                  _loc18_ = int(_loc7_.replace("poster",""));
                  _loc5_.name = "${poster_" + _loc18_ + "_name}";
                  _loc5_.description = "${poster_" + _loc18_ + "_desc}";
               }
               else
               {
                  _loc19_ = _loc6_.getModel().getNumber(RoomObjectVariableEnum.const_277);
                  _loc20_ = _container.sessionDataManager.getFurnitureData(_loc19_);
                  if(_loc20_ != null)
                  {
                     _loc5_.name = _loc20_.title;
                     _loc5_.description = _loc20_.description;
                  }
               }
               if(_loc7_.indexOf("post_it") > -1)
               {
                  _loc5_.isStickie = true;
               }
               _loc5_.image = _loc4_.data;
               _loc5_.isWallItem = param1.category == RoomObjectCategoryEnum.const_28;
               _loc5_.isRoomOwner = _container.roomSession.isRoomOwner;
               _loc5_.isRoomController = _container.roomSession.isRoomController;
               _loc5_.isAnyRoomController = _container.sessionDataManager.isAnyRoomController;
               _container.events.dispatchEvent(_loc5_);
               break;
            case RoomObjectCategoryEnum.const_42:
               if(true || true || true || true || true || true)
               {
                  return null;
               }
               _loc8_ = _container.roomSession.userDataManager.getUserDataByIndex(param1.id);
               if(_loc8_ == null)
               {
                  return null;
               }
               if(_loc8_.type == "pet")
               {
                  _container.roomSession.userDataManager.requestPetInfo(_loc8_.webID);
                  return null;
               }
               if(_loc8_.type == "user")
               {
                  _loc9_ = "null";
                  if(_loc8_.webID != _container.sessionDataManager.userId)
                  {
                     _loc9_ = "null";
                  }
               }
               else
               {
                  if(_loc8_.type != "bot")
                  {
                     return null;
                  }
                  _loc9_ = "null";
               }
               _loc10_ = new RoomWidgetUserInfoUpdateEvent(_loc9_);
               _loc10_.isSpectatorMode = _container.roomSession.isSpectatorMode;
               _loc10_.name = _loc8_.name;
               _loc10_.motto = _loc8_.custom;
               _loc10_.webID = _loc8_.webID;
               _loc10_.userRoomId = param1.id;
               _loc11_ = new Array();
               _loc13_ = _container.roomEngine.getRoomObject(_loc2_,_loc3_,param1.id,param1.category);
               if(_loc13_ != null)
               {
                  _loc10_.carryItem = _loc13_.getModel().getNumber(RoomObjectVariableEnum.const_598);
               }
               if(_loc9_ == RoomWidgetUserInfoUpdateEvent.const_197)
               {
                  _loc10_.canBeAskedAsFriend = _container.friendList.canBeAskedForAFriend(_loc8_.webID);
                  if(_loc13_ != null)
                  {
                     _loc26_ = _loc13_.getModel().getString(RoomObjectVariableEnum.const_944);
                     _loc10_.hasFlatControl = _loc26_ == "furniture" || _loc26_ == "useradmin" || _loc26_ == "";
                     _loc10_.canBeKicked = _loc26_ != "useradmin" && _container.roomSession.isPrivateRoom;
                  }
                  _loc10_.isIgnored = _container.sessionDataManager.isIgnored(_loc8_.name);
                  _loc10_.amIOwner = _container.roomSession.isRoomOwner;
                  _loc10_.amIController = _container.roomSession.isRoomController;
                  _loc10_.amIAnyRoomController = _container.sessionDataManager.isAnyRoomController;
                  _loc10_.respectLeft = _container.sessionDataManager.respectLeft;
                  _loc21_ = _container.sessionDataManager.hasUserRight("fuse_trade");
                  _loc22_ = !_container.sessionDataManager.systemShutDown;
                  _loc23_ = _container.roomSession.isTradingRoom;
                  _loc10_.canTrade = _loc21_ && _loc22_ && _loc23_;
                  _loc10_.canTradeReason = RoomWidgetUserInfoUpdateEvent.const_1277;
                  if(!_loc21_)
                  {
                     _loc10_.canTradeReason = RoomWidgetUserInfoUpdateEvent.TRADE_REASON_NO_OWN_RIGHT;
                  }
                  if(!_loc22_)
                  {
                     _loc10_.canTradeReason = RoomWidgetUserInfoUpdateEvent.const_873;
                  }
                  if(!_loc23_)
                  {
                     _loc10_.canTradeReason = RoomWidgetUserInfoUpdateEvent.const_796;
                  }
                  _loc24_ = _container.sessionDataManager.userId;
                  _loc25_ = _container.sessionDataManager.getUserTags(_loc24_);
                  dispatchUserTags(_loc24_,_loc25_);
               }
               if(_loc9_ == RoomWidgetUserInfoUpdateEvent.BOT)
               {
                  _loc10_.canBeKicked = _container.roomSession.isRoomOwner;
                  _loc11_.push(RoomWidgetUserInfoUpdateEvent.const_1141);
               }
               else
               {
                  _loc11_ = _container.roomSession.userDataManager.getUserBadges(_loc8_.webID);
                  _loc12_ = _container.sessionDataManager.getGroupBadgeId(int(_loc8_.groupID));
                  _loc10_.groupId = int(_loc8_.groupID);
                  _loc10_.groupBadgeId = _loc12_;
               }
               _loc10_.badges = _loc11_;
               _loc14_ = _loc8_.figure;
               _loc15_ = _container.avatarRenderManager.createAvatarImage(_loc14_,AvatarScaleType.const_66);
               if(_loc15_ != null)
               {
                  _loc15_.setDirection(AvatarSetType.const_40,4);
                  _loc10_.image = _loc15_.getImage(AvatarSetType.const_40);
               }
               _container.events.dispatchEvent(_loc10_);
               _loc16_ = _container.sessionDataManager.getUserTags(_loc8_.webID);
               dispatchUserTags(_loc8_.webID,_loc16_);
               _loc27_ = 0;
               while(_loc27_ < _loc11_.length)
               {
                  _loc28_ = _loc11_[_loc27_];
                  _loc17_ = _container.sessionDataManager.getBadgeImage(_loc28_);
                  if(_loc17_ != null)
                  {
                     _container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(_loc28_,_loc17_));
                  }
                  _loc27_++;
               }
               if(_loc12_ != null)
               {
                  _loc29_ = _container.sessionDataManager.getGroupBadgeImage(_loc12_);
                  if(_loc29_ != null)
                  {
                     _container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(_loc12_,_loc29_));
                  }
               }
               break;
         }
         return null;
      }
      
      public function update() : void
      {
      }
      
      private function onFigureUpdate(param1:RoomSessionUserFigureUpdateEvent) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = false;
         if(_container == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(param1.userId < 0)
         {
            return;
         }
         var _loc2_:IUserData = _container.roomSession.userDataManager.getUserDataByIndex(param1.userId);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = _loc2_.webID;
         var _loc4_:* = null;
         if(false)
         {
            _loc5_ = _container.avatarRenderManager.createAvatarImage(param1.figure,AvatarScaleType.const_66);
            if(_loc5_ != null)
            {
               _loc5_.setDirection(AvatarSetType.const_40,4);
               _loc4_ = _loc5_.getImage(AvatarSetType.const_40);
            }
            _loc6_ = _loc3_ == _container.sessionDataManager.userId;
            if(_container != null && false)
            {
               _container.events.dispatchEvent(new RoomWidgetUserFigureUpdateEvent(_loc3_,_loc4_,_loc6_));
            }
         }
      }
      
      private function onPetInfo(param1:RoomSessionPetInfoUpdateEvent) : void
      {
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:IPetInfo = param1.petInfo;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IUserData = _container.roomSession.userDataManager.getUserDataByIndex(_loc2_.roomIndex);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:String = _loc3_.figure;
         var _loc5_:String = _loc4_.slice(_loc4_.indexOf("-") + 1,_loc4_.indexOf("-",_loc4_.indexOf("-") + 1));
         var _loc6_:int = int(_loc5_);
         switch(true)
         {
            case _loc6_ >= 0 && _loc6_ <= 25:
               _loc7_ = "null";
               _loc8_ = 0;
               _loc9_ = _loc6_ - 1;
               break;
            case _loc6_ > 25 && _loc6_ <= 50:
               _loc7_ = "null";
               _loc8_ = 1;
               _loc9_ = _loc6_ - 26;
               break;
            case _loc6_ > 50:
               _loc7_ = "null";
               _loc8_ = 2;
               _loc9_ = _loc6_ - 51;
         }
         var _loc10_:IAvatarImage = _container.avatarRenderManager.createPetImage(_loc4_,_loc7_,AvatarScaleType.const_66);
         if(_loc10_ == null)
         {
            return;
         }
         _loc10_.setDirection(AvatarSetType.const_40,4);
         if(_container != null && false)
         {
            _container.events.dispatchEvent(new RoomWidgetPetInfoUpdateEvent(_loc2_.age,_loc2_.hungerType,_loc2_.thirstType,_loc2_.moodType,_loc2_.natureTypeArray,_loc8_,_loc9_,_loc3_.name,_loc10_.getImage(AvatarSetType.const_40)));
         }
      }
      
      public function getProcessedEvents() : Array
      {
         return [RoomSessionUserBadgesEvent.const_106];
      }
      
      private function dispatchUserTags(param1:int, param2:Array) : void
      {
         if(param2 == null)
         {
            return;
         }
         var _loc3_:* = false;
         if(false)
         {
            _loc3_ = param1 == _container.sessionDataManager.userId;
         }
         if(_container != null && false)
         {
            _container.events.dispatchEvent(new RoomWidgetUserTagsUpdateEvent(param1,param2,_loc3_));
         }
      }
      
      public function get disposed() : Boolean
      {
         return _isDisposed;
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:* = [];
         _loc1_.push(RoomWidgetRoomObjectMessage.const_266);
         _loc1_.push(RoomWidgetUserActionMessage.const_503);
         _loc1_.push(RoomWidgetUserActionMessage.const_664);
         _loc1_.push(RoomWidgetUserActionMessage.const_530);
         _loc1_.push(RoomWidgetUserActionMessage.const_561);
         _loc1_.push(RoomWidgetUserActionMessage.const_560);
         _loc1_.push(RoomWidgetUserActionMessage.const_482);
         _loc1_.push(RoomWidgetUserActionMessage.const_550);
         _loc1_.push(RoomWidgetUserActionMessage.const_485);
         _loc1_.push(RoomWidgetUserActionMessage.const_558);
         _loc1_.push(RoomWidgetUserActionMessage.const_540);
         _loc1_.push(RoomWidgetUserActionMessage.const_668);
         _loc1_.push(RoomWidgetFurniActionMessage.const_236);
         _loc1_.push(RoomWidgetFurniActionMessage.const_604);
         _loc1_.push(RoomWidgetFurniActionMessage.const_494);
         _loc1_.push(RoomWidgetRoomTagSearchMessage.const_644);
         _loc1_.push(RoomWidgetGetBadgeDetailsMessage.const_612);
         _loc1_.push(RoomWidgetUserActionMessage.const_436);
         _loc1_.push(RoomWidgetUserActionMessage.const_658);
         return _loc1_;
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         switch(param1.type)
         {
            case RoomSessionUserBadgesEvent.const_106:
               _loc2_ = param1 as RoomSessionUserBadgesEvent;
               if(_loc2_ == null)
               {
                  return;
               }
               _container.events.dispatchEvent(new RoomWidgetUserBadgesUpdateEvent(_loc2_.userId,_loc2_.badges));
               _loc4_ = 0;
               while(_loc4_ < _loc2_.badges.length)
               {
                  _loc5_ = _loc2_.badges[_loc4_];
                  _loc3_ = _container.sessionDataManager.getBadgeImage(_loc5_);
                  if(_loc3_ != null)
                  {
                     _container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(_loc5_,_loc3_));
                  }
                  _loc4_++;
               }
               break;
         }
      }
      
      public function dispose() : void
      {
         _isDisposed = true;
         container = null;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         if(param1 == null)
         {
            return null;
         }
         if(_container == null)
         {
            return null;
         }
         var _loc2_:int = 0;
         _loc4_ = param1 as RoomWidgetUserActionMessage;
         if(_loc4_ != null)
         {
            _loc2_ = _loc4_.userId;
            if(_loc4_.type == RoomWidgetUserActionMessage.const_436)
            {
               _loc3_ = _container.roomSession.userDataManager.getUserDataByIndex(_loc2_);
            }
            else
            {
               _loc3_ = _container.roomSession.userDataManager.getUserData(_loc2_);
            }
            if(_loc3_ == null)
            {
               return null;
            }
         }
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:RoomWidgetFurniActionMessage = param1 as RoomWidgetFurniActionMessage;
         if(_loc7_ != null)
         {
            _loc5_ = _loc7_.furniId;
            _loc6_ = _loc7_.furniCategory;
         }
         switch(param1.type)
         {
            case RoomWidgetRoomObjectMessage.const_266:
               return handleGetObjectInfoMessage(param1 as RoomWidgetRoomObjectMessage);
            case RoomWidgetUserActionMessage.const_503:
               _container.friendList.askForAFriend(_loc2_,_loc3_.name);
               break;
            case RoomWidgetUserActionMessage.const_664:
               _container.sessionDataManager.giveRespect(_loc2_);
               break;
            case RoomWidgetUserActionMessage.const_530:
               _loc8_ = new RoomWidgetChatInputContentUpdateEvent(RoomWidgetChatInputContentUpdateEvent.const_885,_loc3_.name);
               _container.events.dispatchEvent(_loc8_);
               break;
            case RoomWidgetUserActionMessage.const_561:
               _container.sessionDataManager.ignoreUser(_loc3_.name);
               break;
            case RoomWidgetUserActionMessage.const_560:
               _container.sessionDataManager.unignoreUser(_loc3_.name);
               break;
            case RoomWidgetUserActionMessage.const_482:
               _container.roomSession.kickUser(_loc3_.webID);
               break;
            case RoomWidgetUserActionMessage.const_550:
               _container.roomSession.banUser(_loc3_.webID);
               break;
            case RoomWidgetUserActionMessage.const_485:
               _container.roomSession.assignRights(_loc3_.webID);
               break;
            case RoomWidgetUserActionMessage.const_558:
               _container.roomSession.removeRights(_loc3_.webID);
               break;
            case RoomWidgetUserActionMessage.const_540:
               _loc9_ = _container.roomSession.userDataManager.getUserData(_loc4_.userId);
               _container.inventory.setupTrading(_loc9_.id,_loc9_.name);
               break;
            case RoomWidgetUserActionMessage.const_668:
               _container.sessionDataManager.openHabboHomePage(_loc3_.webID);
               break;
            case RoomWidgetFurniActionMessage.const_604:
               _container.roomEngine.modifyRoomObject(_loc5_,_loc6_,RoomObjectOperationEnum.OBJECT_ROTATE_POSITIVE);
               break;
            case RoomWidgetFurniActionMessage.const_236:
               _container.roomEngine.modifyRoomObject(_loc5_,_loc6_,RoomObjectOperationEnum.OBJECT_MOVE);
               break;
            case RoomWidgetFurniActionMessage.const_494:
               _container.roomEngine.modifyRoomObject(_loc5_,_loc6_,RoomObjectOperationEnum.OBJECT_PICKUP);
               break;
            case RoomWidgetRoomTagSearchMessage.const_644:
               _loc10_ = param1 as RoomWidgetRoomTagSearchMessage;
               if(_loc10_ == null)
               {
                  return null;
               }
               _container.navigator.performTagSearch(_loc10_.tag);
               break;
            case RoomWidgetGetBadgeDetailsMessage.const_612:
               _loc11_ = param1 as RoomWidgetGetBadgeDetailsMessage;
               if(_loc11_ == null)
               {
                  return null;
               }
               _container.sessionDataManager.showGroupBadgeInfo(_loc11_.groupId);
               break;
            case RoomWidgetUserActionMessage.const_436:
               _container.roomSession.kickBot(_loc2_);
               break;
            case RoomWidgetUserActionMessage.const_658:
               if(_container == null || true)
               {
                  break;
               }
               if(_loc3_ == null)
               {
                  break;
               }
               _container.habboHelp.reportUser(_loc2_,_loc3_.name);
               break;
         }
         return null;
      }
      
      private function onBadgeImage(param1:BadgeImageReadyEvent) : void
      {
         if(_container != null && false)
         {
            _container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(param1.badgeId,param1.badgeImage));
         }
      }
      
      public function get type() : String
      {
         return RoomWidgetEnum.const_365;
      }
   }
}
