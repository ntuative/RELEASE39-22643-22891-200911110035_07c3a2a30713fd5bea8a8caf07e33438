package com.sulake.habbo.notifications
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.ICoreUpdateReceiver;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.XMLVariableParser;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosingMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.LoginFailedHotelClosedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
   import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseOKMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.ModMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.UserBannedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboActivityPointNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboBroadcastMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.InfoFeedEnableMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.recycler.RecyclerFinishedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.publicroom.ParkBusCannotEnterMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.RespectNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
   import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosedMessageParser;
   import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosingMessageParser;
   import com.sulake.habbo.communication.messages.parser.availability.LoginFailedHotelClosedMessageParser;
   import com.sulake.habbo.communication.messages.parser.catalog.PurchaseOKMessageParser;
   import com.sulake.habbo.communication.messages.parser.moderation.ModMessageParser;
   import com.sulake.habbo.communication.messages.parser.moderation.UserBannedMessageParser;
   import com.sulake.habbo.communication.messages.parser.notifications.HabboBroadcastMessageParser;
   import com.sulake.habbo.communication.messages.parser.recycler.RecyclerFinishedMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.publicroom.ParkBusCannotEnterMessageParser;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.inventory.enum.FurniCategory;
   import com.sulake.habbo.inventory.enum.InventoryCategory;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.ImageResult;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.display.BitmapData;
   import iid.IIDHabboWindowManager;
   
   public class HabboNotifications extends Component implements IHabboNotifications, ICoreUpdateReceiver, IGetImageListener
   {
      
      private static const const_1016:String = "badges";
      
      private static const const_1013:String = "pixelbalance";
      
      private static const const_1017:String = "credits";
      
      private static const const_1019:String = "inventory";
      
      private static const const_1015:String = "friendlist";
      
      private static const const_1014:String = "selectfurni";
      
      private static const const_1018:String = "selectbadge";
       
      
      private var _assetLibrary:IAssetLibrary;
      
      private var var_502:ParkBusDialogManager;
      
      private var var_1100:IHabboToolbar;
      
      private var var_501:HabboNotificationViewManager;
      
      private var var_1016:IAvatarRenderManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_1767:Boolean;
      
      private var var_524:ISessionDataManager;
      
      private var _communication:IHabboCommunicationManager;
      
      private var var_1099:Boolean;
      
      private var var_32:IHabboInventory;
      
      private var var_188:HabboAlertDialogManager;
      
      private var var_902:Array;
      
      private var var_739:Map;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _friendList:IHabboFriendList;
      
      public function HabboNotifications(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         super(param1,param2,param3);
         _assetLibrary = param3;
         var_902 = new Array();
         var_739 = new Map();
         var_1099 = false;
         var _loc4_:IAsset = _assetLibrary.getAssetByName("habbo_notifications_config_xml");
         var _loc5_:XmlAsset = XmlAsset(_loc4_);
         if(_loc5_ != null)
         {
            XMLVariableParser.parseVariableList(XML(_loc5_.content).children(),var_739);
         }
         var _loc6_:Map = var_739["styles"];
         if(_loc6_ != null)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               _loc8_ = _loc6_.getWithIndex(_loc7_);
               if(_loc8_["icon"] != null)
               {
                  _loc9_ = _assetLibrary.getAssetByName(_loc8_["icon"]) as BitmapDataAsset;
                  _loc10_ = _loc9_.content as BitmapData;
                  _loc8_["icon"] = _loc10_;
               }
               _loc7_++;
            }
         }
         queueInterface(new IIDHabboInventory(),onInventoryReady);
         queueInterface(new IIDHabboFriendList(),onFriendListReady);
         queueInterface(new IIDSessionDataManager(),onSessionDataManagerReady);
         queueInterface(new IIDAvatarRenderManager(),onAvatarRenderManagerReady);
         queueInterface(new IIDHabboCommunicationManager(),onCommunicationComponentInit);
         queueInterface(new IIDRoomEngine(),onRoomEngineReady);
      }
      
      private function onUserBannedMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:UserBannedMessageParser = (param1 as UserBannedMessageEvent).getParser();
         if(_loc2_ == null || var_188 == null)
         {
            return;
         }
         var_188.handleUserBannedMessage(_loc2_.message);
      }
      
      public function addSongPlayingNotification(param1:String, param2:String) : void
      {
         _localization.registerParameter("soundmachine.notification.playing","songname",param1);
         _localization.registerParameter("soundmachine.notification.playing","songauthor",param2);
         var _loc3_:ILocalization = _localization.getLocalization("soundmachine.notification.playing");
         if(_loc3_)
         {
            addItem(_loc3_.value,NotificationType.const_1092);
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
      }
      
      private function onRecyclerFinished(param1:IMessageEvent) : void
      {
         var _loc2_:RecyclerFinishedMessageParser = (param1 as RecyclerFinishedMessageEvent).getParser();
         if(_loc2_ == null || _loc2_.recyclerFinishedStatus != RecyclerFinishedMessageEvent.const_875)
         {
            return;
         }
         var _loc3_:ILocalization = _localization.getLocalization("notifications.text.recycle.ok");
         if(_loc3_)
         {
            addItem(_loc3_.value,NotificationType.const_1094);
         }
         Logger.log("[HabboNotifications] recycle ok");
      }
      
      public function addOfflineNotification(param1:String) : void
      {
         _localization.registerParameter("notifications.text.friend.offline","user_name",param1);
         var _loc2_:ILocalization = _localization.getLocalization("notifications.text.friend.offline");
         if(_loc2_)
         {
            addItem(_loc2_.value,NotificationType.const_1074);
         }
      }
      
      private function onBroadcastMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:HabboBroadcastMessageParser = (param1 as HabboBroadcastMessageEvent).getParser();
         var _loc3_:String = _loc2_.messageText;
         var _loc4_:RegExp = /\\r/g;
         _loc3_ = _loc3_.replace(_loc4_,"\r");
         _windowManager.alert("${notifications.broadcast.title}",_loc3_,0,onBroadcastAlert);
      }
      
      private function onModMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:ModMessageParser = (param1 as ModMessageEvent).getParser();
         if(_loc2_ == null || var_188 == null)
         {
            return;
         }
         var_188.handleModMessage(_loc2_.message,_loc2_.url);
      }
      
      private function onSessionDataManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var_524 = param2 as ISessionDataManager;
      }
      
      private function onLoginFailedHotelClosed(param1:IMessageEvent) : void
      {
         var _loc2_:LoginFailedHotelClosedMessageParser = (param1 as LoginFailedHotelClosedMessageEvent).getParser();
         if(_loc2_ == null || var_188 == null)
         {
            return;
         }
         var_188.handleLoginFailedHotelClosedMessage(_loc2_.openHour,_loc2_.openMinute);
      }
      
      override public function dispose() : void
      {
         if(var_501 != null)
         {
            var_501.dispose();
            var_501 = null;
         }
         if(var_188 != null)
         {
            var_188.dispose();
            var_188 = null;
         }
         if(var_502 != null)
         {
            var_502.dispose();
            var_502 = null;
         }
         super.dispose();
      }
      
      function onActivityPointNotication(param1:IMessageEvent) : void
      {
         var _loc2_:HabboActivityPointNotificationMessageEvent = param1 as HabboActivityPointNotificationMessageEvent;
         Logger.log("Pixels received, count " + _loc2_.amount + ", change " + _loc2_.change);
         _localization.registerParameter("notifications.text.pixels","count",String(_loc2_.amount));
         _localization.registerParameter("notifications.text.pixels","change",String(_loc2_.change));
         var _loc3_:ILocalization = _localization.getLocalization("notifications.text.pixels");
         if(_loc3_ && _loc2_.change > 0)
         {
            addItem(_loc3_.value,NotificationType.const_1205);
         }
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         var _loc2_:* = null;
         if(!var_1767)
         {
            _loc2_ = this._localization.getKey("mod.chatdisclaimer","NA");
            this.addItem(_loc2_,NotificationType.const_909);
            var_1767 = true;
            Logger.log("DISPLAYED MOD INFO: " + _loc2_);
         }
      }
      
      public function onExecuteLink(param1:String) : void
      {
         switch(param1)
         {
            case const_1013:
               break;
            case const_1016:
               if(var_32 != null)
               {
                  var_32.toggleInventoryPage(InventoryCategory.const_260);
               }
               break;
            case const_1018:
               break;
            case const_1019:
               if(var_32 != null)
               {
                  var_32.toggleInventoryPage(InventoryCategory.const_80);
               }
               break;
            case const_1014:
               break;
            case const_1017:
               break;
            case const_1015:
               if(_friendList != null)
               {
                  _friendList.openFriendList();
               }
         }
      }
      
      private function onCommunicationComponentInit(param1:IID = null, param2:IUnknown = null) : void
      {
         _communication = IHabboCommunicationManager(param2);
         queueInterface(new IIDHabboWindowManager(),onWindowManagerReady);
      }
      
      private function onWindowManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _windowManager = IHabboWindowManager(param2);
         queueInterface(new IIDHabboLocalizationManager(),onLocalizationReady);
      }
      
      private function onBadgeImage(param1:BadgeImageReadyEvent) : void
      {
      }
      
      private function onRoomEngineReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _roomEngine = param2 as IRoomEngine;
      }
      
      public function update(param1:uint) : void
      {
         if(var_501.isSpaceAvailable() && false)
         {
            var_501.showItem(getNextItemFromQueue());
         }
      }
      
      private function onParkBusMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:ParkBusCannotEnterMessageParser = (param1 as ParkBusCannotEnterMessageEvent).getParser();
         if(var_502 == null)
         {
            var_502 = new ParkBusDialogManager(_windowManager,assets,_localization);
         }
         if(_loc2_ != null || var_502 != null)
         {
            var_502.handleParkBusCannotEnter(_loc2_.reason);
         }
      }
      
      private function getNextItemFromQueue() : HabboNotificationItem
      {
         var _loc1_:Array = var_902.splice(0,1);
         return _loc1_[0] as HabboNotificationItem;
      }
      
      private function onFriendListReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _friendList = param2 as IHabboFriendList;
      }
      
      private function onInfoFeedEnable(param1:IMessageEvent) : void
      {
         var _loc2_:InfoFeedEnableMessageEvent = param1 as InfoFeedEnableMessageEvent;
         if(_loc2_ != null)
         {
            var_1099 = !_loc2_.enabled;
         }
      }
      
      function onAchievementNotication(param1:IMessageEvent) : void
      {
         var _loc2_:HabboAchievementNotificationMessageEvent = param1 as HabboAchievementNotificationMessageEvent;
         Logger.log("Badge " + _loc2_.badgeID + " level " + _loc2_.level + " received");
         _localization.registerParameter("notifications.text.achievement","badge",_localization.getKey("badge_name_" + _loc2_.badgeID,_loc2_.badgeID));
         _localization.registerParameter("notifications.text.achievement","level",String(_loc2_.level));
         var _loc3_:ILocalization = _localization.getLocalization("notifications.text.achievement");
         var _loc4_:BitmapData = var_524.getBadgeImage(_loc2_.badgeID);
         if(_loc3_)
         {
            addItem(_loc3_.value,NotificationType.const_1115,_loc4_);
         }
      }
      
      public function onBroadcastAlert(param1:IAlertDialog, param2:WindowEvent) : void
      {
         if(param2.type == WindowEvent.const_199 || param2.type == WindowEvent.const_478)
         {
            param1.dispose();
         }
      }
      
      private function onPurchaseOK(param1:IMessageEvent) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:* = null;
         var _loc19_:int = 0;
         var _loc2_:PurchaseOKMessageEvent = param1 as PurchaseOKMessageEvent;
         var _loc3_:PurchaseOKMessageParser = _loc2_.getParser();
         var _loc4_:CatalogPageMessageOfferData = _loc3_.offer;
         var _loc5_:* = null;
         if(_loc4_ != null)
         {
            _loc10_ = _loc4_.offerId;
            _loc11_ = _loc4_.localizationId;
            _loc12_ = _loc4_.priceInCredits;
            _loc13_ = _loc4_.priceInPixels;
            _loc14_ = new Array();
            _loc15_ = _loc4_.products[0];
            if(_loc4_.products.length > 0)
            {
               _loc16_ = var_524.getProductData(_loc15_.productType);
               _loc17_ = var_524.getFurnitureData(_loc15_.furniClassId);
               _loc7_ = var_524.getProductData(_loc4_.localizationId);
               switch(_loc15_.productType)
               {
                  case "s":
                     _loc6_ = _roomEngine.getFurnitureIcon(_loc15_.furniClassId,this);
                     break;
                  case "i":
                     _loc19_ = tempCategoryMapping("I",_loc15_.furniClassId);
                     if(_loc19_ == 1)
                     {
                        _loc6_ = _roomEngine.getWallItemIcon(_loc15_.furniClassId,this,_loc15_.extraParam);
                     }
                     else
                     {
                        switch(_loc19_)
                        {
                           case FurniCategory.const_316:
                              _loc18_ = (var_32 as Component).assets.getAssetByName("icon_wallpaper_png") as BitmapDataAsset;
                              if(_loc18_ != null)
                              {
                                 _loc5_ = (_loc18_.content as BitmapData).clone();
                              }
                              break;
                           case FurniCategory.const_282:
                              _loc18_ = (var_32 as Component).assets.getAssetByName("icon_landscape_png") as BitmapDataAsset;
                              if(_loc18_ != null)
                              {
                                 _loc5_ = (_loc18_.content as BitmapData).clone();
                              }
                              break;
                           case FurniCategory.const_254:
                              _loc18_ = (var_32 as Component).assets.getAssetByName("icon_floor_png") as BitmapDataAsset;
                              if(_loc18_ != null)
                              {
                                 _loc5_ = (_loc18_.content as BitmapData).clone();
                              }
                        }
                        _loc6_ = null;
                     }
                     break;
                  case "e":
                     _loc18_ = (var_32 as Component).assets.getAssetByName("fx_icon_" + _loc15_.furniClassId + "_png") as BitmapDataAsset;
                     if(_loc18_ != null)
                     {
                        _loc5_ = (_loc18_.content as BitmapData).clone();
                     }
                     break;
                  default:
                     Logger.log("[HabboNotifications] Can not yet handle this type of product: ");
               }
               if(_loc6_ != null)
               {
                  _loc5_ = _loc6_.data;
               }
            }
         }
         var _loc8_:String = _loc7_ == null ? "product" : _loc7_.name;
         _localization.registerParameter("notifications.text.purchase.ok","productName",_loc8_);
         var _loc9_:ILocalization = _localization.getLocalization("notifications.text.purchase.ok");
         if(_loc9_)
         {
            addItem(_loc9_.value,NotificationType.const_909,_loc5_);
         }
         Logger.log("[HabboNotifications] purchase ok");
      }
      
      public function addOnlineNotification(param1:String, param2:String) : void
      {
         _localization.registerParameter("notifications.text.friend.online","user_name",param1);
         var _loc3_:ILocalization = _localization.getLocalization("notifications.text.friend.online");
         var _loc4_:* = null;
         var _loc5_:IAvatarImage = var_1016.createAvatarImage(param2,AvatarScaleType.const_66);
         if(_loc5_ != null)
         {
            _loc5_.setDirection(AvatarSetType.const_50,3);
            _loc4_ = _loc5_.getCroppedImage(AvatarSetType.const_50);
         }
         if(_loc3_)
         {
            addItem(_loc3_.value,NotificationType.const_1209,_loc4_);
         }
      }
      
      private function onHotelClosing(param1:IMessageEvent) : void
      {
         var _loc2_:InfoHotelClosingMessageParser = (param1 as InfoHotelClosingMessageEvent).getParser();
         if(_loc2_ == null || var_188 == null)
         {
            return;
         }
         var_188.handleHotelClosingMessage(_loc2_.minutesUntilClosing);
      }
      
      public function addItem(param1:String, param2:String, param3:BitmapData = null) : int
      {
         if(var_1099)
         {
            return 0;
         }
         var _loc4_:Map = var_739["styles"];
         if(_loc4_ == null)
         {
            return 0;
         }
         var _loc5_:Map = _loc4_[param2];
         if(_loc5_ == null)
         {
            return 0;
         }
         var _loc6_:HabboNotificationItemStyle = new HabboNotificationItemStyle(_loc5_);
         if(param3 != null)
         {
            _loc6_.icon = param3;
         }
         var _loc7_:HabboNotificationItem = new HabboNotificationItem(param1,_loc6_,this);
         var_902.push(_loc7_);
         return var_902.length;
      }
      
      private function onAvatarRenderManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_1016 = param2 as IAvatarRenderManager;
      }
      
      private function onInventoryReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_32 = param2 as IHabboInventory;
      }
      
      private function onToolbarReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var_1100 = IHabboToolbar(param2);
         var_1100.events.addEventListener(HabboToolbarEvent.const_78,onHabboToolbarEvent);
      }
      
      private function onToolbarRepositionEvent(param1:HabboToolbarEvent) : void
      {
      }
      
      private function onSubscriptionInfo(param1:IMessageEvent) : void
      {
         var _loc5_:* = null;
         Logger.log("[HabboNotifications] subscription update");
         var _loc2_:ScrSendUserInfoMessageParser = (param1 as ScrSendUserInfoEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.responseType != 2)
         {
            return;
         }
         var _loc3_:int = Math.max(0,_loc2_.daysToPeriodEnd);
         var _loc4_:int = Math.max(0,_loc2_.periodsSubscribedAhead);
         if(_loc4_ > 0)
         {
            _localization.registerParameter("notifications.text.clubdays.long","days",String(_loc3_));
            _localization.registerParameter("notifications.text.clubdays.long","months",String(_loc4_));
            _loc5_ = _localization.getLocalization("notifications.text.clubdays.long");
         }
         else
         {
            _localization.registerParameter("notifications.text.clubdays","days",String(_loc3_));
            _loc5_ = _localization.getLocalization("notifications.text.clubdays");
         }
         if(_loc5_)
         {
            addItem(_loc5_.value,NotificationType.const_210);
         }
      }
      
      private function onLocalizationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _localization = param2 as IHabboLocalizationManager;
         var_188 = new HabboAlertDialogManager(_windowManager,_localization);
         queueInterface(new IIDHabboToolbar(),onToolbarReady);
      }
      
      function onRespectNotification(param1:IMessageEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:RespectNotificationMessageEvent = param1 as RespectNotificationMessageEvent;
         if(this.var_524.userId == _loc2_.userId)
         {
            _localization.registerParameter("notifications.text.respect.2","count",String(_loc2_.respectTotal));
            _loc3_ = _localization.getLocalization("notifications.text.respect.1");
            _loc4_ = _localization.getLocalization("notifications.text.respect.2");
            if(_loc3_)
            {
               addItem(_loc3_.value,NotificationType.const_813);
            }
            if(_loc4_)
            {
               addItem(_loc4_.value,NotificationType.const_813);
            }
         }
      }
      
      public function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == HabboToolbarEvent.const_78)
         {
            Logger.log("Notifications: starting to respond to notifications");
            var_501 = new HabboNotificationViewManager(_assetLibrary,_windowManager,var_739["styles"],var_739["view"],var_1100);
            _communication.addHabboConnectionMessageEvent(new HabboBroadcastMessageEvent(onBroadcastMessageEvent));
            _communication.addHabboConnectionMessageEvent(new HabboAchievementNotificationMessageEvent(onAchievementNotication));
            _communication.addHabboConnectionMessageEvent(new HabboActivityPointNotificationMessageEvent(onActivityPointNotication));
            _communication.addHabboConnectionMessageEvent(new RespectNotificationMessageEvent(onRespectNotification));
            _communication.addHabboConnectionMessageEvent(new PurchaseOKMessageEvent(onPurchaseOK));
            _communication.addHabboConnectionMessageEvent(new RecyclerFinishedMessageEvent(onRecyclerFinished));
            _communication.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(onSubscriptionInfo));
            _communication.addHabboConnectionMessageEvent(new InfoFeedEnableMessageEvent(onInfoFeedEnable));
            _communication.addHabboConnectionMessageEvent(new ModMessageEvent(onModMessageEvent));
            _communication.addHabboConnectionMessageEvent(new UserBannedMessageEvent(onUserBannedMessageEvent));
            _communication.addHabboConnectionMessageEvent(new InfoHotelClosingMessageEvent(onHotelClosing));
            _communication.addHabboConnectionMessageEvent(new InfoHotelClosedMessageEvent(onHotelClosed));
            _communication.addHabboConnectionMessageEvent(new LoginFailedHotelClosedMessageEvent(onLoginFailedHotelClosed));
            _communication.addHabboConnectionMessageEvent(new ParkBusCannotEnterMessageEvent(onParkBusMessageEvent));
            _communication.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
            registerUpdateReceiver(var_501,1);
            registerUpdateReceiver(this,2);
            var_524.events.addEventListener(BadgeImageReadyEvent.BADGE_READY,onBadgeImage);
            var_1100.events.addEventListener(HabboToolbarEvent.TOOLBAR_ORIENTATION,onToolbarRepositionEvent);
            return;
         }
      }
      
      private function onHotelClosed(param1:IMessageEvent) : void
      {
         var _loc2_:InfoHotelClosedMessageParser = (param1 as InfoHotelClosedMessageEvent).getParser();
         if(_loc2_ == null || var_188 == null)
         {
            return;
         }
         var_188.handleHotelClosedMessage(_loc2_.openHour,_loc2_.openMinute,_loc2_.userThrownOutAtClose);
      }
      
      private function tempCategoryMapping(param1:String, param2:int) : int
      {
         if(param1 == "S")
         {
            return 1;
         }
         if(param1 == "I")
         {
            if(param2 == 3001)
            {
               return FurniCategory.const_316;
            }
            if(param2 == 3002)
            {
               return FurniCategory.const_254;
            }
            if(param2 == 4057)
            {
               return FurniCategory.const_282;
            }
            if(param2 == 3002)
            {
               return FurniCategory.const_254;
            }
            if(param2 == 4001)
            {
               return FurniCategory.const_124;
            }
            return 1;
         }
         return 1;
      }
   }
}
