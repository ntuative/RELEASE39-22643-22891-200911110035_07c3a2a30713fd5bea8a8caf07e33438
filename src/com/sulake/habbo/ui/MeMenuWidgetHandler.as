package com.sulake.habbo.ui
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.avatar.events.AvatarEditorClosedEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.enum.CatalogPageName;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.inventory.enum.InventoryCategory;
   import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.session.events.HabboSessionFigureUpdatedEvent;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
   import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
   import com.sulake.habbo.widget.RoomWidgetEnum;
   import com.sulake.habbo.widget.events.RoomWidgetAvatarEditorUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetFrameUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetHabboClubUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetSettingsUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetToolbarClickedUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEffectsUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetAvatarEditorMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetDanceMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetGetEffectsMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetGetSettingsMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetNavigateToRoomMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetOpenCatalogMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetOpenInventoryMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRedeemClubPromoMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetSelectEffectMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetSelectOutfitMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetSetToolbarIconMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetShowOwnRoomsMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetStopEffectMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetStoreSettingsMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetToolbarMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetWaveMessage;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class MeMenuWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var _isDisposed:Boolean = false;
      
      private var var_84:IHabboCatalog;
      
      private var var_32:IHabboInventory;
      
      private var var_198:IHabboToolbar;
      
      public function MeMenuWidgetHandler()
      {
         super();
         Logger.log("[MeMenuWidgetHandler]");
      }
      
      public function get type() : String
      {
         return RoomWidgetEnum.const_426;
      }
      
      private function setMeMenuToolbarIcon(param1:Boolean) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc2_:* = null;
         if(false)
         {
            _loc4_ = _container.sessionDataManager.figure;
            _loc5_ = _container.avatarRenderManager.createAvatarImage(_loc4_,AvatarScaleType.const_66);
            if(_loc5_ != null)
            {
               _loc5_.setDirection(AvatarSetType.const_50,3);
               _loc2_ = _loc5_.getCroppedImage(AvatarSetType.const_50);
            }
         }
         var _loc3_:Component = _container.roomWidgetFactory as Component;
         if(_loc3_ != null)
         {
            if(_loc2_ == null)
            {
               _loc7_ = _loc3_.assets.getAssetByName("memenu_toolbar_icon") as BitmapDataAsset;
               _loc6_ = _loc7_.content as BitmapData;
            }
            else
            {
               _loc6_ = _loc2_;
            }
            Logger.log("MeMenuWidgetHandler: set toolbar icon: " + var_198 + " " + _loc6_);
            if(var_198 != null && _loc6_ != null)
            {
               _loc8_ = new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.const_928,HabboToolbarIconEnum.MEMENU);
               _loc8_.bitmapData = _loc6_;
               var_198.events.dispatchEvent(_loc8_);
            }
         }
      }
      
      private function onFigureUpdate(param1:HabboSessionFigureUpdatedEvent) : void
      {
         if(_container == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         var _loc2_:* = param1.userId == _container.sessionDataManager.userId;
         if(_loc2_)
         {
            setMeMenuToolbarIcon(false);
         }
         if(_container != null && false)
         {
         }
      }
      
      public function update() : void
      {
         if(_container)
         {
            _container.events.dispatchEvent(new RoomWidgetFrameUpdateEvent());
         }
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         if(_container != null)
         {
            if(false)
            {
               _container.sessionDataManager.events.removeEventListener(HabboSessionFigureUpdatedEvent.const_475,onFigureUpdate);
            }
            if(false)
            {
               _container.avatarEditor.events.removeEventListener(AvatarEditorClosedEvent.AVATAREDITOR_CLOSED,onAvatarEditorClosed);
            }
            _container = null;
         }
         _container = param1;
         if(_container != null && false)
         {
            _container.sessionDataManager.events.addEventListener(HabboSessionFigureUpdatedEvent.const_475,onFigureUpdate);
         }
         var_32 = _container.inventory;
         if(var_32 != null)
         {
            (var_32 as Component).events.addEventListener(HabboInventoryEffectsEvent.const_814,onAvatarEffectsChanged);
            (var_32 as Component).events.addEventListener(HabboInventoryHabboClubEvent.const_569,onHabboClubSubscriptionChanged);
         }
         var_198 = _container.toolbar;
         if(var_198)
         {
            var_198.events.addEventListener(HabboToolbarEvent.const_78,onHabboToolbarEvent);
            var_198.events.addEventListener(HabboToolbarEvent.const_55,onHabboToolbarEvent);
            setMeMenuToolbarIcon(false);
         }
         if(false)
         {
            _container.avatarEditor.events.addEventListener(AvatarEditorClosedEvent.AVATAREDITOR_CLOSED,onAvatarEditorClosed);
         }
         var_84 = _container.catalog;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      private function onAvatarEffectsChanged(param1:Event = null) : void
      {
         var _loc2_:* = null;
         if(_container == null)
         {
            return;
         }
         Logger.log("[MeMenuWidgetHandler] Received Avatar Effects Have Changed Event...\t");
         if(var_32 != null)
         {
            _loc2_ = var_32.getAvatarEffects();
            _container.events.dispatchEvent(new RoomWidgetUpdateEffectsUpdateEvent(_loc2_));
         }
      }
      
      private function onHabboClubSubscriptionChanged(param1:Event = null) : void
      {
         var _loc2_:Boolean = false;
         if(var_32 != null)
         {
            _loc2_ = false;
            if(_container != null && false)
            {
               _loc2_ = _container.sessionDataManager.hasUserRight("fuse_use_club_dance");
            }
            _container.events.dispatchEvent(new RoomWidgetHabboClubUpdateEvent(var_32.clubDays,var_32.clubPeriods,var_32.clubPastPeriods,_loc2_));
         }
      }
      
      public function get disposed() : Boolean
      {
         return _isDisposed;
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:* = [];
         _loc1_.push(RoomWidgetWaveMessage.const_649);
         _loc1_.push(RoomWidgetDanceMessage.const_539);
         _loc1_.push(RoomWidgetGetEffectsMessage.const_670);
         _loc1_.push(RoomWidgetSelectEffectMessage.const_687);
         _loc1_.push(RoomWidgetSelectEffectMessage.const_519);
         _loc1_.push(RoomWidgetSelectEffectMessage.const_637);
         _loc1_.push(RoomWidgetOpenInventoryMessage.const_642);
         _loc1_.push(RoomWidgetOpenCatalogMessage.const_610);
         _loc1_.push(RoomWidgetStopEffectMessage.const_573);
         _loc1_.push(RoomWidgetNavigateToRoomMessage.const_1238);
         _loc1_.push(RoomWidgetNavigateToRoomMessage.const_809);
         _loc1_.push(RoomWidgetToolbarMessage.const_487);
         _loc1_.push(RoomWidgetToolbarMessage.const_521);
         _loc1_.push(RoomWidgetAvatarEditorMessage.const_651);
         _loc1_.push(RoomWidgetAvatarEditorMessage.const_1268);
         _loc1_.push(RoomWidgetSelectOutfitMessage.const_882);
         _loc1_.push(RoomWidgetShowOwnRoomsMessage.const_505);
         _loc1_.push(RoomWidgetRequestWidgetMessage.const_588);
         _loc1_.push(RoomWidgetRedeemClubPromoMessage.const_565);
         _loc1_.push(RoomWidgetGetSettingsMessage.const_537);
         _loc1_.push(RoomWidgetStoreSettingsMessage.const_1225);
         _loc1_.push(RoomWidgetStoreSettingsMessage.const_488);
         _loc1_.push(RoomWidgetStoreSettingsMessage.const_648);
         return _loc1_;
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function dispose() : void
      {
         _isDisposed = true;
         _container = null;
         var_32 = null;
         var_198 = null;
         var_84 = null;
      }
      
      private function onAvatarEditorClosed(param1:Event = null) : void
      {
         if(_container == null)
         {
            return;
         }
         Logger.log("[MeMenuWidgetHandler] Received Avatar Editor Closed Event...");
         _container.events.dispatchEvent(new RoomWidgetAvatarEditorUpdateEvent(RoomWidgetAvatarEditorUpdateEvent.const_549));
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
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
         var _loc14_:Boolean = false;
         var _loc15_:int = 0;
         var _loc16_:* = null;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:* = null;
         var _loc20_:* = null;
         var _loc21_:* = null;
         var _loc22_:* = null;
         var _loc23_:Boolean = false;
         var _loc24_:* = null;
         var _loc25_:* = false;
         var _loc26_:* = false;
         Logger.log("[MeMenuWidgetHandler] Processing in MeMenuWidgetHandler: " + param1.type);
         switch(param1.type)
         {
            case RoomWidgetRequestWidgetMessage.const_588:
               if(_container != null && false)
               {
                  _loc8_ = new HabboToolbarEvent(HabboToolbarEvent.const_55);
                  _loc8_.iconId = HabboToolbarIconEnum.MEMENU;
                  _container.toolbar.events.dispatchEvent(_loc8_);
               }
               break;
            case RoomWidgetWaveMessage.const_649:
               if(_container != null && false)
               {
                  _loc9_ = param1 as RoomWidgetWaveMessage;
                  _container.roomSession.sendWaveMessage();
               }
               break;
            case RoomWidgetDanceMessage.const_539:
               if(_container != null && false)
               {
                  _loc10_ = param1 as RoomWidgetDanceMessage;
                  _container.roomSession.sendDanceMessage(_loc10_.style);
               }
               break;
            case RoomWidgetGetEffectsMessage.const_670:
               if(var_32 != null)
               {
                  _loc11_ = var_32.getAvatarEffects();
                  _container.events.dispatchEvent(new RoomWidgetUpdateEffectsUpdateEvent(_loc11_));
               }
               break;
            case RoomWidgetSelectEffectMessage.const_687:
               if(var_32 != null)
               {
                  _loc12_ = param1 as RoomWidgetSelectEffectMessage;
                  var_32.setEffectSelected(_loc12_.effectType);
               }
               break;
            case RoomWidgetSelectEffectMessage.const_519:
               if(var_32 != null)
               {
                  _loc13_ = param1 as RoomWidgetSelectEffectMessage;
                  var_32.setEffectDeselected(_loc13_.effectType);
               }
               break;
            case RoomWidgetOpenCatalogMessage.const_610:
               _loc2_ = param1 as RoomWidgetOpenCatalogMessage;
               if(var_84 != null && _loc2_.pageKey == RoomWidgetOpenCatalogMessage.const_420)
               {
                  var_84.openCatalogPage(CatalogPageName.const_429,true);
               }
               break;
            case RoomWidgetOpenInventoryMessage.const_642:
               _loc3_ = param1 as RoomWidgetOpenInventoryMessage;
               if(var_32 != null)
               {
                  Logger.log("MeMenuWidgetHandler open inventory: " + _loc3_.inventoryType);
                  switch(_loc3_.inventoryType)
                  {
                     case RoomWidgetOpenInventoryMessage.const_744:
                        var_84.openCatalogPage(CatalogPageName.const_1212,true);
                        break;
                     case RoomWidgetOpenInventoryMessage.const_772:
                        var_32.toggleInventoryPage(InventoryCategory.const_260);
                        break;
                     case RoomWidgetOpenInventoryMessage.const_1120:
                        var_32.toggleInventoryPage(InventoryCategory.const_80);
                        break;
                     case RoomWidgetOpenInventoryMessage.const_1194:
                        break;
                     default:
                        Logger.log("MeMenuWidgetHandler: unknown inventory type: " + _loc3_.inventoryType);
                  }
               }
               break;
            case RoomWidgetSelectEffectMessage.const_637:
            case RoomWidgetStopEffectMessage.const_573:
               Logger.log("STOP ALL EFFECTS");
               if(var_32 != null)
               {
                  var_32.deselectAllEffects();
               }
               break;
            case RoomWidgetSetToolbarIconMessage.const_855:
               _loc4_ = param1 as RoomWidgetSetToolbarIconMessage;
               switch(_loc4_.widgetType)
               {
                  case RoomWidgetSetToolbarIconMessage.const_1078:
                     break;
                  default:
                     Logger.log("MeMenuWidgetHandler: unknown icon widget type: " + _loc4_.widgetType);
               }
               break;
            case RoomWidgetNavigateToRoomMessage.const_809:
               Logger.log("MeMenuWidgetHandler: GO HOME");
               if(_container != null)
               {
                  _container.navigator.goToHomeRoom();
               }
               break;
            case RoomWidgetShowOwnRoomsMessage.const_505:
               if(_container != null)
               {
                  _container.navigator.showOwnRooms();
               }
               break;
            case RoomWidgetToolbarMessage.const_487:
               _loc5_ = param1 as RoomWidgetToolbarMessage;
               if(var_198)
               {
                  var_198.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_74,HabboToolbarIconEnum.MEMENU,_loc5_.window));
                  if(var_32 != null)
                  {
                     _loc14_ = false;
                     if(_container != null && false)
                     {
                        _loc14_ = _container.sessionDataManager.hasUserRight("fuse_use_club_dance");
                     }
                     _container.events.dispatchEvent(new RoomWidgetHabboClubUpdateEvent(var_32.clubDays,var_32.clubPeriods,var_32.clubPastPeriods,_loc14_));
                  }
               }
               if(false)
               {
                  _loc15_ = _container.sessionDataManager != null ? int(_container.sessionDataManager.userId) : -1;
                  _loc16_ = _container.roomSession.userDataManager.getUserData(_loc15_);
                  _loc17_ = 0;
                  _loc18_ = 0;
                  _container.roomEngine.selectAvatar(_loc17_,_loc18_,_loc16_.id,true);
               }
               break;
            case RoomWidgetToolbarMessage.const_521:
               _loc6_ = param1 as RoomWidgetToolbarMessage;
               if(var_198)
               {
                  var_198.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_409,HabboToolbarIconEnum.MEMENU,_loc6_.window));
               }
               break;
            case RoomWidgetAvatarEditorMessage.const_651:
               Logger.log("MeMenuWidgetHandler: Open avatar editor...");
               if(_container)
               {
                  _loc19_ = param1 as RoomWidgetAvatarEditorMessage;
                  _loc20_ = _loc19_.context;
                  _container.avatarEditor.openEditor(_loc20_);
                  _loc21_ = _container.sessionDataManager.figure;
                  _loc22_ = _container.sessionDataManager.gender;
                  _loc23_ = false;
                  _container.avatarEditor.loadAvatarInEditor(_loc21_,_loc22_,_loc23_);
                  if(false && !_loc23_)
                  {
                     _loc24_ = _container.config.getKey("avatar.editor.club.promo.image");
                     _loc25_ = int(_container.config.getKey("avatar.editor.club.promo")) > 0;
                     if(_loc25_ && false)
                     {
                        _container.events.dispatchEvent(new RoomWidgetAvatarEditorUpdateEvent(RoomWidgetAvatarEditorUpdateEvent.const_374,_loc24_,RoomWidgetAvatarEditorUpdateEvent.const_756));
                     }
                     _loc26_ = int(_container.config.getKey("avatar.editor.trial.promo")) > 0;
                     if(_loc26_ && true)
                     {
                        _container.events.dispatchEvent(new RoomWidgetAvatarEditorUpdateEvent(RoomWidgetAvatarEditorUpdateEvent.const_374,_loc24_,RoomWidgetAvatarEditorUpdateEvent.const_1187));
                     }
                  }
               }
               break;
            case RoomWidgetRedeemClubPromoMessage.const_565:
               _loc7_ = param1 as RoomWidgetRedeemClubPromoMessage;
               if(_loc7_ != null)
               {
                  _container.catalog.redeemClubPromo(_loc7_.code,_loc7_.isTrial);
               }
               break;
            case RoomWidgetGetSettingsMessage.const_537:
               _container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.const_281,_container.soundManager.volume));
               break;
            case RoomWidgetStoreSettingsMessage.const_488:
               _container.soundManager.volume = (param1 as RoomWidgetStoreSettingsMessage).volume;
               _container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.const_281,_container.soundManager.volume));
               break;
            case RoomWidgetStoreSettingsMessage.const_648:
               _container.soundManager.previewVolume = (param1 as RoomWidgetStoreSettingsMessage).volume;
               _container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.const_281,_container.soundManager.volume));
               break;
            default:
               Logger.log("Unhandled message in MeMenuWidgetHandler: " + param1.type);
         }
         return null;
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == HabboToolbarEvent.const_78)
         {
            setMeMenuToolbarIcon(false);
         }
         if(_container == null)
         {
            return;
         }
         if(param1.type == HabboToolbarEvent.const_55)
         {
            switch(param1.iconId)
            {
               case HabboToolbarIconEnum.MEMENU:
                  _container.events.dispatchEvent(new RoomWidgetToolbarClickedUpdateEvent(RoomWidgetToolbarClickedUpdateEvent.ICON_TYPE_ME_MENU));
                  break;
               case HabboToolbarIconEnum.ROOMINFO:
                  _container.events.dispatchEvent(new RoomWidgetToolbarClickedUpdateEvent(RoomWidgetToolbarClickedUpdateEvent.ICON_TYPE_ROOM_INFO));
            }
         }
      }
   }
}
