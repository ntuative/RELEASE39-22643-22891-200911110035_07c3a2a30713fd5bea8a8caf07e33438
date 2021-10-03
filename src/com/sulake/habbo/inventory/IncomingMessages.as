package com.sulake.habbo.inventory
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffect;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectActivatedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectAddedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectExpiredMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgesEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniData;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListInsertEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListRemoveEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListUpdateEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.PostItPlacedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetInventoryEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.purse.CreditBalanceEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.ItemDataStructure;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAcceptEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAlreadyOpenEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCloseEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCompletedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingConfirmationEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingItemListEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingNotOpenEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOpenEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOtherNotAllowedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingYouAreNotAllowedEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboActivityPointNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.OpenConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboUserBadgesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
   import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestFurniInventoryComposer;
   import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectActivatedMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectAddedMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectExpiredMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectsMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgesParser;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListInsertParser;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListParser;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListRemoveParser;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.PostItPlacedParser;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetInventoryMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingAcceptParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingAlreadyOpenParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCloseParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCompletedParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingConfirmationParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingItemListParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingNotOpenParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOpenParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOtherNotAllowedParser;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingYouAreNotAllowedParser;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
   import com.sulake.habbo.inventory.achievements.Achievement;
   import com.sulake.habbo.inventory.achievements.AchievementsModel;
   import com.sulake.habbo.inventory.badges.BadgesModel;
   import com.sulake.habbo.inventory.effects.Effect;
   import com.sulake.habbo.inventory.effects.EffectsModel;
   import com.sulake.habbo.inventory.enum.FurniCategory;
   import com.sulake.habbo.inventory.enum.InventoryCategory;
   import com.sulake.habbo.inventory.enum.InventorySubCategory;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.inventory.items.FloorItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.IItem;
   import com.sulake.habbo.inventory.items.WallItem;
   import com.sulake.habbo.inventory.pets.PetsModel;
   import com.sulake.habbo.inventory.trading.TradingModel;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.ISessionDataManager;
   
   public class IncomingMessages
   {
       
      
      private var var_44:IHabboCommunicationManager;
      
      private var var_32:HabboInventory;
      
      public function IncomingMessages(param1:HabboInventory)
      {
         super();
         var_32 = param1;
         var_44 = var_32.communication;
         var_44.addHabboConnectionMessageEvent(new FurniListEvent(onFurniList));
         var_44.addHabboConnectionMessageEvent(new FurniListInsertEvent(onFurniListInsert));
         var_44.addHabboConnectionMessageEvent(new FurniListRemoveEvent(onFurniListRemove));
         var_44.addHabboConnectionMessageEvent(new FurniListUpdateEvent(onFurniListUpdate));
         var_44.addHabboConnectionMessageEvent(new PostItPlacedEvent(onPostItPlaced));
         var_44.addHabboConnectionMessageEvent(new AvatarEffectsMessageEvent(onAvatarEffects));
         var_44.addHabboConnectionMessageEvent(new AvatarEffectActivatedMessageEvent(onAvatarEffectActivated));
         var_44.addHabboConnectionMessageEvent(new AvatarEffectAddedMessageEvent(onAvatarEffectAdded));
         var_44.addHabboConnectionMessageEvent(new AvatarEffectExpiredMessageEvent(onAvatarEffectExpired));
         var_44.addHabboConnectionMessageEvent(new HabboActivityPointNotificationMessageEvent(onPixelBalance));
         var_44.addHabboConnectionMessageEvent(new CreditBalanceEvent(onCreditsBalance));
         var_44.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(onClubStatus));
         var_44.addHabboConnectionMessageEvent(new BadgesEvent(onBadges));
         var_44.addHabboConnectionMessageEvent(new HabboUserBadgesMessageEvent(onUserBadges));
         var_44.addHabboConnectionMessageEvent(new HabboAchievementNotificationMessageEvent(onAchievementReceived));
         var_44.addHabboConnectionMessageEvent(new AchievementsEvent(onAchievements));
         var_44.addHabboConnectionMessageEvent(new TradingAcceptEvent(onTradingAccepted,TradingAcceptParser));
         var_44.addHabboConnectionMessageEvent(new TradingConfirmationEvent(onTradingConfirmation,TradingConfirmationParser));
         var_44.addHabboConnectionMessageEvent(new TradingAlreadyOpenEvent(onTradingAlreadyOpen,TradingAlreadyOpenParser));
         var_44.addHabboConnectionMessageEvent(new TradingCloseEvent(onTradingClose,TradingCloseParser));
         var_44.addHabboConnectionMessageEvent(new TradingCompletedEvent(onTradingCompleted,TradingCompletedParser));
         var_44.addHabboConnectionMessageEvent(new TradingItemListEvent(onTradingItemList,TradingItemListParser));
         var_44.addHabboConnectionMessageEvent(new TradingNotOpenEvent(onTradingNotOpen,TradingNotOpenParser));
         var_44.addHabboConnectionMessageEvent(new TradingOpenEvent(onTradingOpen,TradingOpenParser));
         var_44.addHabboConnectionMessageEvent(new TradingOtherNotAllowedEvent(onTradingOtherNotAllowed,TradingOtherNotAllowedParser));
         var_44.addHabboConnectionMessageEvent(new TradingYouAreNotAllowedEvent(onTradingYouAreNotAllowed,TradingYouAreNotAllowedParser));
         var_44.addHabboConnectionMessageEvent(new OpenConnectionMessageEvent(onRoomClosed));
         var_44.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(onRoomClosed));
         var_44.addHabboConnectionMessageEvent(new FlatAccessDeniedMessageEvent(onRoomClosed));
         var_44.addHabboConnectionMessageEvent(new PetInventoryEvent(onPets));
      }
      
      public function onFurniListRemove(param1:IMessageEvent) : void
      {
         var _loc2_:FurniListRemoveParser = (param1 as FurniListRemoveEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = _loc2_.stripId;
         var _loc4_:FurniModel = var_32.furniModel;
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.removeFurni(_loc3_);
      }
      
      public function onFurniListUpdate(param1:IMessageEvent) : void
      {
         var _loc2_:IConnection = getConnection();
         if(_loc2_ != null)
         {
            _loc2_.send(new RequestFurniInventoryComposer(0,0));
         }
         var_32.setInventoryCategoryInit(InventoryCategory.const_80,false);
      }
      
      public function onPostItPlaced(param1:IMessageEvent) : void
      {
         var _loc2_:PostItPlacedParser = (param1 as PostItPlacedEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = _loc2_.id;
         var _loc4_:int = _loc2_.itemsLeft;
         var _loc5_:FurniModel = var_32.furniModel;
         if(_loc5_ == null)
         {
            return;
         }
         _loc5_.updatePostItCount(_loc3_,_loc4_);
      }
      
      public function onAvatarEffectActivated(param1:IMessageEvent) : void
      {
         var _loc2_:EffectsModel = var_32.effectsModel;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:AvatarEffectActivatedMessageParser = (param1 as AvatarEffectActivatedMessageEvent).getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:int = _loc3_.type;
         _loc2_.setEffectActivated(_loc4_);
         var_32.notifyChangedEffects();
      }
      
      private function onTradingAccepted(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = var_32.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      public function onAvatarEffects(param1:IMessageEvent) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc2_:EffectsModel = var_32.effectsModel;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:AvatarEffectsMessageParser = (param1 as AvatarEffectsMessageEvent).getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:Array = _loc3_.effects;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_] as AvatarEffect;
            _loc7_ = new Effect();
            _loc7_.type = _loc6_.type;
            _loc7_.duration = _loc6_.duration;
            _loc7_.effectsInInventory = _loc6_.inactiveEffectsInInventory;
            if(_loc6_.secondsLeftIfActive >= 0)
            {
               _loc7_.isActive = true;
               _loc7_.secondsLeft = _loc6_.secondsLeftIfActive;
               ++_loc7_.effectsInInventory;
            }
            else if(_loc6_.secondsLeftIfActive == -1)
            {
               _loc7_.isActive = false;
               _loc7_.secondsLeft = _loc6_.duration;
            }
            _loc2_.addEffect(_loc7_,false);
            _loc5_++;
         }
         var_32.setInventoryCategoryInit(InventoryCategory.const_688);
         _loc2_.refreshViews();
         var_32.notifyChangedEffects();
      }
      
      private function onTradingItemList(param1:IMessageEvent) : void
      {
         var _loc5_:* = 0;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc2_:TradingItemListEvent = param1 as TradingItemListEvent;
         var _loc3_:Map = new Map();
         var _loc4_:Map = new Map();
         var _loc11_:FurniModel = var_32.furniModel;
         if(_loc11_ == null)
         {
            return;
         }
         _loc5_ = uint(_loc2_.firstUserItemArray.length);
         _loc10_ = 0;
         while(_loc10_ < _loc5_)
         {
            _loc9_ = _loc2_.firstUserItemArray[_loc10_] as ItemDataStructure;
            _loc7_ = _loc9_.itemTypeID;
            _loc8_ = String(_loc7_);
            if(!_loc9_.groupable)
            {
               _loc8_ = "itemid" + _loc9_.itemID;
            }
            if(_loc9_.category == FurniCategory.const_124)
            {
               _loc8_ = String(_loc7_) + "poster" + _loc9_.itemSpecificData;
            }
            _loc6_ = !!_loc9_.groupable ? _loc3_.getValue(_loc8_) as GroupItem : null;
            if(_loc9_.itemType == "S")
            {
               if(_loc6_ == null)
               {
                  _loc6_ = _loc11_.createNewGroupItemTemplate(_loc7_,FurniModel.const_39,_loc9_.category,_loc9_.itemSpecificData);
                  _loc3_.add(_loc8_,_loc6_);
               }
               _loc6_.push(new FloorItem(_loc9_.itemID,_loc9_.itemTypeID,_loc9_.roomItemID,_loc9_.category,true,true,true,_loc9_.itemSpecificData,_loc9_.timeToExpiration,_loc9_.creationDay,_loc9_.creationMonth,_loc9_.creationYear,null,_loc9_.songID));
            }
            else
            {
               if(_loc9_.itemType != "I")
               {
                  throw new Error("Unsupported item category: \"" + _loc9_.itemType + "\"");
               }
               if(_loc6_ == null)
               {
                  _loc6_ = _loc11_.createNewGroupItemTemplate(_loc7_,FurniModel.const_41,_loc9_.category,_loc9_.itemSpecificData);
                  _loc3_.add(_loc8_,_loc6_);
               }
               _loc6_.push(new WallItem(_loc9_.itemID,_loc9_.itemTypeID,_loc9_.roomItemID,_loc9_.category,true,true,true,_loc9_.itemSpecificData));
            }
            _loc10_++;
         }
         _loc5_ = uint(_loc2_.secondUserItemArray.length);
         _loc10_ = 0;
         while(_loc10_ < _loc5_)
         {
            _loc9_ = _loc2_.secondUserItemArray[_loc10_] as ItemDataStructure;
            _loc7_ = _loc9_.itemTypeID;
            _loc8_ = String(_loc7_);
            if(_loc9_.category == FurniCategory.const_124)
            {
               _loc8_ = String(_loc7_) + "poster" + _loc9_.itemSpecificData;
            }
            _loc6_ = !!_loc9_.groupable ? _loc4_.getValue(_loc8_) as GroupItem : null;
            if(_loc9_.itemType == "S")
            {
               if(_loc6_ == null)
               {
                  _loc6_ = _loc11_.createNewGroupItemTemplate(_loc7_,FurniModel.const_39,_loc9_.category,_loc9_.itemSpecificData);
                  _loc4_.add(_loc8_,_loc6_);
               }
               _loc6_.push(new FloorItem(_loc9_.itemID,_loc9_.itemTypeID,_loc9_.roomItemID,_loc9_.category,true,true,true,_loc9_.itemSpecificData,_loc9_.timeToExpiration,_loc9_.creationDay,_loc9_.creationMonth,_loc9_.creationYear,null,_loc9_.songID));
            }
            else
            {
               if(_loc9_.itemType != "I")
               {
                  throw new Error("Unsupported item category: \"" + _loc9_.itemType + "\"");
               }
               if(_loc6_ == null)
               {
                  _loc6_ = _loc11_.createNewGroupItemTemplate(_loc7_,FurniModel.const_41,_loc9_.category,_loc9_.itemSpecificData);
                  _loc4_.add(_loc8_,_loc6_);
               }
               _loc6_.push(new WallItem(_loc9_.itemID,_loc9_.itemTypeID,_loc9_.roomItemID,_loc9_.category,true,true,true,_loc9_.itemSpecificData));
            }
            _loc10_++;
         }
         var _loc12_:TradingModel = var_32.tradingModel;
         if(_loc12_ != null)
         {
            _loc12_.updateItemGroupMaps(_loc2_.firstUserID,_loc3_,_loc2_.secondUserID,_loc4_);
         }
      }
      
      private function onTradingYouAreNotAllowed(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = var_32.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      public function onClubStatus(param1:IMessageEvent) : void
      {
         var _loc2_:ScrSendUserInfoMessageParser = (param1 as ScrSendUserInfoEvent).getParser();
         if(_loc2_.productName == "habbo_club" || _loc2_.productName == "club_habbo")
         {
            var_32.setClubStatus(_loc2_.periodsSubscribedAhead,_loc2_.daysToPeriodEnd,_loc2_.hasEverBeenMember);
            var_32.events.dispatchEvent(new HabboInventoryHabboClubEvent());
         }
      }
      
      public function onAchievementReceived(param1:IMessageEvent) : void
      {
         var _loc2_:HabboAchievementNotificationMessageEvent = param1 as HabboAchievementNotificationMessageEvent;
         var _loc3_:BadgesModel = var_32.badgesModel;
         if(_loc3_ != null)
         {
            _loc3_.updateBadge(_loc2_.badgeID,false);
            _loc3_.removeBadge(_loc2_.removedBadgeID);
         }
         var _loc4_:AchievementsModel = var_32.achievementsModel;
         if(_loc4_ != null)
         {
            _loc4_.removeAchievement(_loc2_.removedBadgeID,_loc2_.level);
         }
      }
      
      private function getConnection() : IConnection
      {
         if(var_44 == null)
         {
            return null;
         }
         return var_44.getHabboMainConnection(null);
      }
      
      private function onPets(param1:PetInventoryEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:PetInventoryMessageParser = param1.getParser();
         var _loc3_:PetsModel = var_32.petsModel;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.pets = _loc2_.pets;
         _loc3_.updateView();
      }
      
      private function onTradingClose(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = var_32.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingConfirmation(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = var_32.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      public function onUserBadges(param1:IMessageEvent) : void
      {
         var _loc2_:HabboUserBadgesMessageEvent = param1 as HabboUserBadgesMessageEvent;
         if(_loc2_.userId != var_32.sessionData.userId)
         {
            return;
         }
         var _loc3_:BadgesModel = var_32.badgesModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:Array = _loc2_.badges;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc3_.updateBadge(_loc4_[_loc5_],true);
            _loc5_++;
         }
         _loc3_.updateView();
      }
      
      private function onTradingNotOpen(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = var_32.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      public function onAvatarEffectExpired(param1:IMessageEvent) : void
      {
         var _loc2_:EffectsModel = var_32.effectsModel;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:AvatarEffectExpiredMessageParser = (param1 as AvatarEffectExpiredMessageEvent).getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:int = _loc3_.type;
         _loc2_.setEffectExpired(_loc4_);
         var_32.notifyChangedEffects();
      }
      
      public function dispose() : void
      {
         var_32 = null;
         var_44 = null;
      }
      
      private function onTradingAlreadyOpen(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = var_32.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      public function onCreditsBalance(param1:IMessageEvent) : void
      {
         var_32.creditBalance = (param1 as CreditBalanceEvent).getParser().balance;
      }
      
      public function onAchievements(param1:IMessageEvent) : void
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc2_:AchievementsEvent = param1 as AchievementsEvent;
         var _loc3_:AchievementsMessageParser = _loc2_.getParser() as AchievementsMessageParser;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:AchievementsModel = var_32.achievementsModel;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:Array = _loc3_.achievements;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc7_ = new Achievement();
            _loc8_ = _loc5_[_loc6_] as AchievementData;
            _loc7_.type = _loc8_.type;
            _loc7_.badgeId = _loc8_.badgeId;
            _loc7_.level = _loc8_.level;
            _loc4_.addAchievement(_loc7_,false);
            _loc6_++;
         }
         _loc4_.refreshViews();
         var_32.setInventoryCategoryInit(InventoryCategory.const_273);
      }
      
      public function onFurniList(param1:IMessageEvent) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc14_:int = 0;
         var _loc2_:FurniListParser = (param1 as FurniListEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Array = _loc2_.getFurni();
         var _loc4_:FurniModel = var_32.furniModel;
         if(_loc4_ == null)
         {
            return;
         }
         var_32.setInventoryCategoryInit(InventoryCategory.const_80);
         var _loc7_:Array = new Array();
         var _loc8_:Array = new Array();
         var _loc9_:Array = new Array();
         var _loc10_:Array = new Array();
         _loc4_.getAllStripIds(_loc7_);
         var _loc11_:int = 0;
         while(_loc11_ < _loc3_.length)
         {
            _loc14_ = FurniData(_loc3_[_loc11_]).stripId;
            if(_loc7_.indexOf(_loc14_) != -1)
            {
               _loc9_.push(_loc14_);
            }
            _loc8_.push(_loc14_);
            _loc11_++;
         }
         _loc11_ = 0;
         while(_loc11_ < _loc7_.length)
         {
            if(_loc8_.indexOf(_loc7_[_loc11_]) == -1)
            {
               _loc10_.push(_loc7_[_loc11_]);
            }
            _loc11_++;
         }
         if(_loc7_.length == 0)
         {
            _loc4_.clearFurniList();
         }
         var _loc12_:int = 0;
         while(_loc12_ < _loc3_.length)
         {
            _loc6_ = FurniData(_loc3_[_loc12_]);
            if(_loc9_.indexOf(_loc6_.stripId) == -1)
            {
               if(_loc6_.itemType == "S")
               {
                  _loc5_ = new FloorItem(_loc6_.stripId,_loc6_.classId,_loc6_.method_4,_loc6_.category,_loc6_.isGroupable,_loc6_.isTradeable,_loc6_.isRecyclable,_loc6_.stuffData,_loc6_.expiryTime,0,0,0,_loc6_.slotId,_loc6_.songId);
               }
               else
               {
                  if(_loc6_.itemType != "I")
                  {
                     throw new Error("Unknown inventory item category: \"" + _loc6_.itemType + "\"");
                  }
                  _loc5_ = new WallItem(_loc6_.stripId,_loc6_.classId,_loc6_.method_4,_loc6_.category,_loc6_.isGroupable,_loc6_.isTradeable,_loc6_.isRecyclable,_loc6_.stuffData);
               }
               if(_loc7_.length == 0)
               {
                  _loc4_.addFurniAsLast(_loc5_,true);
               }
               else
               {
                  _loc4_.addFurniAt(_loc5_,true,0);
               }
            }
            _loc12_++;
         }
         var _loc13_:int = 0;
         while(_loc13_ < _loc10_.length)
         {
            _loc4_.removeFurni(_loc10_[_loc13_]);
            _loc13_++;
         }
         _loc4_.updateLocks();
         if(_loc4_.getSelectedItemIndex(FurniModel.const_39) == -1)
         {
            _loc4_.toggleItemSelection(FurniModel.const_39,0);
         }
         if(_loc4_.getSelectedItemIndex(FurniModel.const_41) == -1)
         {
            _loc4_.toggleItemSelection(FurniModel.const_41,0);
         }
         _loc4_.initListImages();
         _loc4_.setListInited();
      }
      
      private function onRoomClosed(param1:IMessageEvent) : void
      {
         var_32.closeView();
      }
      
      private function onTradingCompleted(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = var_32.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingOtherNotAllowed(param1:IMessageEvent) : void
      {
         var _loc2_:TradingModel = var_32.tradingModel;
         if(_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }
      
      private function onTradingOpen(param1:IMessageEvent) : void
      {
         var _loc12_:int = 0;
         var _loc13_:* = null;
         var _loc14_:Boolean = false;
         var _loc2_:ISessionDataManager = var_32.sessionData;
         var _loc3_:IRoomSession = var_32.roomSession;
         if(_loc3_ == null)
         {
            return;
         }
         var_32.toggleInventorySubPage(InventorySubCategory.const_258);
         var _loc4_:TradingOpenEvent = param1 as TradingOpenEvent;
         var _loc5_:int = _loc4_.userID;
         var _loc6_:String = _loc3_.userDataManager.getUserData(_loc5_).name;
         var _loc7_:* = _loc4_.userCanTrade > 0;
         var _loc8_:int = _loc4_.otherUserID;
         var _loc9_:String = _loc3_.userDataManager.getUserData(_loc8_).name;
         var _loc10_:* = _loc4_.otherUserCanTrade > 0;
         if(_loc8_ == _loc2_.userId)
         {
            _loc12_ = _loc5_;
            _loc13_ = _loc6_;
            _loc14_ = _loc7_;
            _loc5_ = _loc8_;
            _loc6_ = _loc9_;
            _loc7_ = Boolean(_loc10_);
            _loc8_ = _loc12_;
            _loc9_ = _loc13_;
            _loc10_ = Boolean(_loc14_);
         }
         var _loc11_:TradingModel = var_32.tradingModel;
         if(_loc11_ != null)
         {
            _loc11_.startTrading(_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_);
         }
      }
      
      public function onBadges(param1:IMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc2_:BadgesParser = (param1 as BadgesEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:BadgesModel = var_32.badgesModel;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc6_:Array = _loc2_.getAllBadgeIds();
         var _loc7_:Array = _loc2_.getActiveBadgeIds();
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc5_ = _loc6_[_loc4_];
            if(_loc7_.indexOf(_loc5_) == -1)
            {
               _loc3_.updateBadge(_loc5_,false);
            }
            else
            {
               _loc3_.updateBadge(_loc5_,true);
            }
            _loc4_++;
         }
         _loc3_.forceSelection();
         _loc3_.updateView();
         var_32.setInventoryCategoryInit(InventoryCategory.const_260);
      }
      
      public function onPixelBalance(param1:IMessageEvent) : void
      {
         var_32.pixelBalance = (param1 as HabboActivityPointNotificationMessageEvent).amount;
      }
      
      public function onFurniListInsert(param1:IMessageEvent) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc2_:FurniListInsertParser = (param1 as FurniListInsertEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Array = _loc2_.getFurni();
         var _loc4_:FurniModel = var_32.furniModel;
         if(_loc4_ == null)
         {
            return;
         }
         if(!_loc4_.isListInited())
         {
            return;
         }
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc6_ = FurniData(_loc3_[_loc7_]);
            if(_loc6_.itemType == "S")
            {
               _loc5_ = new FloorItem(_loc6_.stripId,_loc6_.classId,_loc6_.method_4,_loc6_.category,_loc6_.isGroupable,_loc6_.isTradeable,_loc6_.isRecyclable,_loc6_.stuffData,_loc6_.expiryTime,0,0,0,_loc6_.slotId,_loc6_.songId);
            }
            else
            {
               if(_loc6_.itemType != "I")
               {
                  throw new Error("Unknown inventory item category: \"" + _loc6_.itemType + "\"");
               }
               _loc5_ = new WallItem(_loc6_.stripId,_loc6_.classId,_loc6_.method_4,_loc6_.category,_loc6_.isGroupable,_loc6_.isTradeable,_loc6_.isRecyclable,_loc6_.stuffData);
            }
            _loc4_.addFurniAsLast(_loc5_);
            _loc7_++;
         }
      }
      
      public function onAvatarEffectAdded(param1:IMessageEvent) : void
      {
         var _loc2_:EffectsModel = var_32.effectsModel;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:AvatarEffectAddedMessageParser = (param1 as AvatarEffectAddedMessageEvent).getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:int = _loc3_.type;
         var _loc5_:int = _loc3_.duration;
         var _loc6_:Effect = new Effect();
         _loc6_.type = _loc4_;
         _loc6_.duration = _loc5_;
         _loc6_.secondsLeft = _loc5_;
         _loc2_.addEffect(_loc6_);
         var_32.notifyChangedEffects();
      }
   }
}
