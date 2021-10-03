package com.sulake.habbo.widget.infostand
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.widget.RoomWidgetBase;
   import com.sulake.habbo.widget.events.RoomWidgetBadgeImageUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetPetInfoUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserBadgesUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserFigureUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetUserTagsUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   public class InfostandWidget extends RoomWidgetBase
   {
       
      
      private var var_1492:Array;
      
      private const const_1290:String = "infostand_user_view";
      
      private var var_1490:InfoStandPetView;
      
      private var var_1491:InfoStandPetData;
      
      private const const_1288:String = "infostand_bot_view";
      
      private var var_837:InfoStandFurniView;
      
      private var var_347:InfostandFurniData;
      
      private var var_563:InfoStandBotView;
      
      private var _mainContainer:IWindowContainer;
      
      private var _config:IHabboConfigurationManager;
      
      private const const_1289:String = "infostand_pet_view";
      
      private const const_1291:String = "infostand_furni_view";
      
      private var var_302:InfoStandUserView;
      
      private var var_390:InfostandUserData;
      
      public function InfostandWidget(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboLocalizationManager, param4:IHabboConfigurationManager)
      {
         super(param1,param2,param3);
         _config = param4;
         var_837 = new InfoStandFurniView(this,const_1291);
         var_302 = new InfoStandUserView(this,const_1290);
         var_1490 = new InfoStandPetView(this,const_1289);
         var_563 = new InfoStandBotView(this,const_1288);
         var_390 = new InfostandUserData();
         var_347 = new InfostandFurniData();
         var_1491 = new InfoStandPetData();
         mainContainer.visible = false;
      }
      
      private function onUserTags(param1:RoomWidgetUserTagsUpdateEvent) : void
      {
         if(param1.isOwnUser)
         {
            var_1492 = param1.tags;
         }
         if(param1.userId != userData.userId)
         {
            return;
         }
         if(param1.isOwnUser)
         {
            var_302.setTags(param1.tags);
         }
         else
         {
            var_302.setTags(param1.tags,var_1492);
         }
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_284,onRoomObjectSelected);
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_196,onClose);
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_244,onRoomObjectRemoved);
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_122,onRoomObjectRemoved);
         param1.addEventListener(RoomWidgetUserInfoUpdateEvent.const_257,onUserInfo);
         param1.addEventListener(RoomWidgetUserInfoUpdateEvent.const_197,onUserInfo);
         param1.addEventListener(RoomWidgetUserInfoUpdateEvent.BOT,onBotInfo);
         param1.addEventListener(RoomWidgetFurniInfoUpdateEvent.const_674,onFurniInfo);
         param1.addEventListener(RoomWidgetUserTagsUpdateEvent.const_141,onUserTags);
         param1.addEventListener(RoomWidgetUserFigureUpdateEvent.const_131,onUserFigureUpdate);
         param1.addEventListener(RoomWidgetUserBadgesUpdateEvent.const_106,onUserBadges);
         param1.addEventListener(RoomWidgetBadgeImageUpdateEvent.const_641,onBadgeImage);
         param1.addEventListener(RoomWidgetPetInfoUpdateEvent.const_125,onPetInfo);
         super.registerUpdateEvents(param1);
      }
      
      override public function get mainWindow() : IWindow
      {
         return mainContainer;
      }
      
      private function onPetInfo(param1:RoomWidgetPetInfoUpdateEvent) : void
      {
         petData.setData(param1);
         var_1490.update(param1);
         selectView(const_1289);
      }
      
      public function get userData() : InfostandUserData
      {
         return var_390;
      }
      
      private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         userData.setData(param1);
         var_302.update(param1);
         selectView(const_1290);
      }
      
      private function onUserBadges(param1:RoomWidgetUserBadgesUpdateEvent) : void
      {
         if(param1.userId != userData.userId)
         {
            return;
         }
         userData.badges = param1.badges;
         var_302.clearBadges();
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_284,onRoomObjectSelected);
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_196,onClose);
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_244,onRoomObjectRemoved);
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_122,onRoomObjectRemoved);
         param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.const_257,onUserInfo);
         param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.const_197,onUserInfo);
         param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.BOT,onBotInfo);
         param1.removeEventListener(RoomWidgetFurniInfoUpdateEvent.const_674,onFurniInfo);
         param1.removeEventListener(RoomWidgetUserTagsUpdateEvent.const_141,onUserTags);
         param1.removeEventListener(RoomWidgetUserFigureUpdateEvent.const_131,onUserFigureUpdate);
         param1.removeEventListener(RoomWidgetUserBadgesUpdateEvent.const_106,onUserBadges);
         param1.removeEventListener(RoomWidgetBadgeImageUpdateEvent.const_641,onBadgeImage);
         param1.removeEventListener(RoomWidgetPetInfoUpdateEvent.const_125,onPetInfo);
      }
      
      override public function dispose() : void
      {
         var_302.dispose();
         var_302 = null;
         var_837.dispose();
         var_837 = null;
         var_563.dispose();
         var_563 = null;
         super.dispose();
      }
      
      private function onFurniInfo(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         furniData.setData(param1);
         var_837.update(param1);
         selectView(const_1291);
      }
      
      private function onBotInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         userData.setData(param1);
         var_563.update(param1);
         selectView(const_1288);
      }
      
      private function onUserFigureUpdate(param1:RoomWidgetUserFigureUpdateEvent) : void
      {
         if(!param1.isOwnUser)
         {
         }
         if(param1.userId != userData.userId)
         {
            return;
         }
         if(userData.isBot())
         {
            var_563.image = param1.image;
         }
         else
         {
            var_302.image = param1.image;
         }
      }
      
      private function onBadgeImage(param1:RoomWidgetBadgeImageUpdateEvent) : void
      {
         var _loc2_:int = userData.badges.indexOf(param1.badgeID);
         if(_loc2_ >= 0)
         {
            if(userData.isBot())
            {
               var_563.setBadgeImage(_loc2_,param1.badgeImage);
            }
            else
            {
               var_302.setBadgeImage(_loc2_,param1.badgeImage);
            }
            return;
         }
         if(param1.badgeID == userData.groupBadgeId)
         {
            var_302.setGroupBadgeImage(param1.badgeImage);
            return;
         }
      }
      
      private function selectView(param1:String) : void
      {
         hideChildren();
         var _loc2_:IWindow = mainContainer.getChildByName(param1) as IWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.visible = true;
         mainContainer.visible = true;
         mainContainer.width = _loc2_.width;
         mainContainer.height = _loc2_.height;
      }
      
      public function get mainContainer() : IWindowContainer
      {
         if(_mainContainer == null)
         {
            _mainContainer = windowManager.createWindow("infostand_main_container","",HabboWindowType.const_53,HabboWindowStyle.const_38,HabboWindowParam.const_38,new Rectangle(0,0,50,100)) as IWindowContainer;
            _mainContainer.tags.push("room_widget_infostand");
            _mainContainer.background = true;
            _mainContainer.color = 0;
         }
         return _mainContainer;
      }
      
      public function get furniData() : InfostandFurniData
      {
         return var_347;
      }
      
      private function onClose(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         close();
      }
      
      public function get config() : IHabboConfigurationManager
      {
         return _config;
      }
      
      private function onRoomObjectRemoved(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         var _loc2_:* = false;
         switch(param1.type)
         {
            case RoomWidgetRoomObjectUpdateEvent.const_122:
               _loc2_ = param1.id == var_347.id;
               break;
            case RoomWidgetRoomObjectUpdateEvent.const_244:
               _loc2_ = param1.id == var_390.userRoomId;
         }
         if(_loc2_)
         {
            close();
         }
      }
      
      public function get petData() : InfoStandPetData
      {
         return var_1491;
      }
      
      public function refreshContainer() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < mainContainer.numChildren)
         {
            _loc1_ = mainContainer.getChildAt(_loc2_);
            if(_loc1_.visible)
            {
               mainContainer.width = _loc1_.width;
               mainContainer.height = _loc1_.height;
            }
            _loc2_++;
         }
      }
      
      private function hideChildren() : void
      {
         var _loc1_:int = 0;
         if(_mainContainer != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _mainContainer.numChildren)
            {
               _mainContainer.getChildAt(_loc1_).visible = false;
               _loc1_++;
            }
         }
      }
      
      private function onRoomObjectSelected(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         var _loc2_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.const_266,param1.id,param1.category);
         messageListener.processWidgetMessage(_loc2_);
      }
      
      public function close() : void
      {
         hideChildren();
      }
   }
}
