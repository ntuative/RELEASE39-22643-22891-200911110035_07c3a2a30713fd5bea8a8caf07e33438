package com.sulake.habbo.session
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.CoreComponent;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.availability.AvailabilityStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.ChatMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.RespectUserMessageComposer;
   import com.sulake.habbo.communication.messages.parser.availability.AvailabilityStatusMessageParser;
   import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.configuration.enum.HabboConfigurationEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.events.HabboSessionFigureUpdatedEvent;
   import com.sulake.habbo.session.furniture.FurnitureDataParser;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.session.product.ProductDataParser;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IConfirmDialog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.Dictionary;
   import iid.IIDHabboWindowManager;
   
   public class SessionDataManager extends Component implements ISessionDataManager
   {
       
      
      private var var_1236:UserTagManager;
      
      private var var_828:String;
      
      private var var_561:Array;
      
      private var var_678:int = 0;
      
      private var var_992:Dictionary;
      
      private var var_1237:GroupDetailsView;
      
      private var _name:String;
      
      private var _furnitureParser:FurnitureDataParser;
      
      private var var_993:Dictionary;
      
      private var _localization:IHabboLocalizationManager;
      
      private var var_36:IRoomSessionManager;
      
      private var var_994:BadgeImageManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_1469:Boolean;
      
      private var _id:int;
      
      private var var_677:IgnoredUsersManager;
      
      private var var_674:Dictionary;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _gender:String;
      
      private var var_1470:Boolean;
      
      private var var_832:ProductDataParser;
      
      private var var_160:IHabboConfigurationManager;
      
      private var var_833:HabboGroupInfoManager;
      
      private var var_2005:int = 0;
      
      public function SessionDataManager(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
         var_561 = [];
         var_1236 = new UserTagManager(events);
         var_833 = new HabboGroupInfoManager(this,events);
         var_677 = new IgnoredUsersManager(this);
         queueInterface(new IIDHabboWindowManager(),onWindowManagerReady);
         queueInterface(new IIDHabboCommunicationManager(),onHabboCommunicationReady);
         queueInterface(new IIDHabboConfigurationManager(),onConfigurationReady);
         queueInterface(new IIDHabboLocalizationManager(),onLocalizationReady);
         queueInterface(new IIDHabboRoomSessionManager(),onRoomSessionManagerReady);
      }
      
      private function onProductsReady(param1:Event = null) : void
      {
         var_832.removeEventListener(ProductDataParser.READY,onProductsReady);
         var_832 = null;
         var_993 = new Dictionary();
         var_992 = new Dictionary();
         var _loc2_:String = var_160.getKey("furnidata.load.url");
         var _loc3_:String = var_160.getKey("external.hash");
         _loc2_ = _loc2_.replace("%hash%",_loc3_);
         _furnitureParser = new FurnitureDataParser(_loc2_,var_993,var_992,_localization);
         _furnitureParser.addEventListener(FurnitureDataParser.READY,onFurnitureReady);
      }
      
      public function getUserTags(param1:int) : Array
      {
         return var_1236.getTags(param1);
      }
      
      public function getProductData(param1:String) : IProductData
      {
         return var_674[param1];
      }
      
      private function onConfigurationInit(param1:Event = null) : void
      {
         var_674 = new Dictionary();
         var _loc2_:String = var_160.getKey("productdata.load.url");
         var _loc3_:String = var_160.getKey("external.hash");
         _loc2_ = _loc2_.replace("%hash%",_loc3_);
         var_832 = new ProductDataParser(_loc2_,var_674);
         var_832.addEventListener(ProductDataParser.READY,onProductsReady);
      }
      
      public function getFurnitureData(param1:int) : IFurnitureData
      {
         if(var_993 == null)
         {
            return null;
         }
         return var_993[String(param1)];
      }
      
      public function get configuration() : IHabboConfigurationManager
      {
         return var_160;
      }
      
      private function sendPickAllFurnitureMessage() : void
      {
         var _loc1_:IConnection = _communication.getHabboMainConnection(null);
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.send(new ChatMessageComposer(":pickall"));
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return var_36;
      }
      
      public function getGroupBadgeId(param1:int) : String
      {
         return var_833.getBadgeId(param1);
      }
      
      public function unignoreUser(param1:String) : void
      {
         var_677.unignoreUser(param1);
      }
      
      public function get systemOpen() : Boolean
      {
         return var_1469;
      }
      
      public function getGroupBadgeImage(param1:String) : BitmapData
      {
         return var_994.getBadgeImage(param1,BadgeImageManager.const_940);
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:UserObjectEvent = param1 as UserObjectEvent;
         var _loc3_:UserObjectMessageParser = _loc2_.getParser();
         _id = _loc3_.id;
         _name = _loc3_.name;
         var_2005 = _loc3_.respectTotal;
         var_678 = _loc3_.respectLeft;
         var_828 = _loc3_.figure;
         _gender = _loc3_.sex;
         var_677.initIgnoreList();
         if(false)
         {
            ExternalInterface.call("FlashExternalInterface.openHabblet","news");
         }
      }
      
      public function pickAllFurniture(param1:int, param2:int) : void
      {
         var roomId:int = param1;
         var roomCategory:int = param2;
         if(var_36 == null || _windowManager == null)
         {
            return;
         }
         var session:IRoomSession = var_36.getSession(roomId,roomCategory);
         if(session == null)
         {
            return;
         }
         if(session.isRoomOwner || isAnyRoomController)
         {
            _windowManager.confirm("${generic.alert.title}","${room.confirm.pick_all}",0,function(param1:IConfirmDialog, param2:Event):void
            {
               param1.dispose();
               if(param2.type == WindowEvent.const_199)
               {
                  sendPickAllFurnitureMessage();
               }
            });
         }
      }
      
      public function method_11(param1:String) : IFurnitureData
      {
         if(var_992 == null)
         {
            return null;
         }
         return getFurnitureData(int(var_992[param1]));
      }
      
      public function getGroupDetails(param1:int) : HabboGroupDetails
      {
         return var_833.getGroupDetails(param1);
      }
      
      public function get userId() : int
      {
         return _id;
      }
      
      private function onWindowManagerReady(param1:IID, param2:IUnknown) : void
      {
         _windowManager = param2 as IHabboWindowManager;
      }
      
      public function isIgnored(param1:String) : Boolean
      {
         return var_677.isIgnored(param1);
      }
      
      private function onLocalizationReady(param1:IID, param2:IUnknown) : void
      {
         if(param2 == null)
         {
            return;
         }
         _localization = param2 as IHabboLocalizationManager;
         initBadgeImageManager();
      }
      
      private function onAvailabilityStatus(param1:IMessageEvent) : void
      {
         var _loc2_:AvailabilityStatusMessageParser = (param1 as AvailabilityStatusMessageEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var_1469 = _loc2_.isOpen;
         var_1470 = _loc2_.onShutDown;
      }
      
      public function giveRespect(param1:int) : void
      {
         var _loc2_:IConnection = _communication.getHabboMainConnection(null);
         if(param1 < 0 || var_678 < 1 || _loc2_ == null)
         {
            throw new Error("Failed to give respect to user: " + param1);
         }
         _loc2_.send(new RespectUserMessageComposer(param1));
         var_678 = var_678 - 1;
      }
      
      public function getBadgeImage(param1:String) : BitmapData
      {
         return var_994.getBadgeImage(param1);
      }
      
      private function onConfigurationReady(param1:IID, param2:IUnknown) : void
      {
         if(param2 == null)
         {
            return;
         }
         var_160 = param2 as IHabboConfigurationManager;
         initBadgeImageManager();
         (var_160 as Component).events.addEventListener(HabboConfigurationEvent.INIT,onConfigurationInit);
      }
      
      public function showGroupBadgeInfo(param1:int) : void
      {
         if(var_1237 == null)
         {
            var_1237 = new GroupDetailsView(this);
         }
         var _loc2_:HabboGroupDetails = var_833.getGroupDetails(param1);
         if(_loc2_ != null)
         {
            var_1237.showGroupDetails(param1);
         }
      }
      
      private function onFurnitureReady(param1:Event = null) : void
      {
         _furnitureParser.removeEventListener(FurnitureDataParser.READY,onFurnitureReady);
         _furnitureParser = null;
      }
      
      public function hasUserRight(param1:String) : Boolean
      {
         if(var_561 == null)
         {
            return false;
         }
         return var_561.indexOf(param1) >= 0;
      }
      
      private function onUserChange(param1:IMessageEvent) : void
      {
         var _loc2_:UserChangeMessageEvent = param1 as UserChangeMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.id == -1)
         {
            var_828 = _loc2_.figure;
            _gender = _loc2_.sex;
            events.dispatchEvent(new HabboSessionFigureUpdatedEvent(_id,var_828));
         }
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function openHabboHomePage(param1:int) : void
      {
         var urlString:String = null;
         var userId:int = param1;
         if(var_160 != null)
         {
            urlString = var_160.getKey("link.format.userpage");
            urlString = urlString.replace("%ID%",String(userId));
            try
            {
               navigateToURL(new URLRequest(urlString),"habboMain");
            }
            catch(e:Error)
            {
               Logger.log("Error occurred!");
            }
         }
      }
      
      public function ignoreUser(param1:String) : void
      {
         var_677.ignoreUser(param1);
      }
      
      private function onUserRights(param1:IMessageEvent) : void
      {
         var _loc2_:UserRightsMessageEvent = param1 as UserRightsMessageEvent;
         var_561 = _loc2_.rights;
      }
      
      private function onHabboCommunicationReady(param1:IID, param2:IUnknown) : void
      {
         _communication = param2 as IHabboCommunicationManager;
         if(_communication == null)
         {
            return;
         }
         _communication.addHabboConnectionMessageEvent(new UserRightsMessageEvent(onUserRights));
         _communication.addHabboConnectionMessageEvent(new UserObjectEvent(onUserObject));
         _communication.addHabboConnectionMessageEvent(new UserChangeMessageEvent(onUserChange));
         _communication.addHabboConnectionMessageEvent(new AvailabilityStatusMessageEvent(onAvailabilityStatus));
         var_1236.communication = _communication;
         var_833.communication = _communication;
         var_677.registerMessageEvents();
      }
      
      public function get systemShutDown() : Boolean
      {
         return var_1470;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return _communication;
      }
      
      public function get isAnyRoomController() : Boolean
      {
         if(var_561 == null)
         {
            return false;
         }
         return var_561.indexOf("fuse_any_room_controller") >= 0;
      }
      
      private function initBadgeImageManager() : void
      {
         var _loc1_:* = null;
         if(var_994 != null)
         {
            return;
         }
         if(var_160 == null || _localization == null)
         {
            return;
         }
         if(context is CoreComponent)
         {
            _loc1_ = (context as CoreComponent).assets;
         }
         var_994 = new BadgeImageManager(_loc1_,events,var_160,_localization);
      }
      
      private function onRoomSessionManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_36 = param2 as IRoomSessionManager;
      }
      
      public function get respectLeft() : int
      {
         return var_678;
      }
      
      public function get userName() : String
      {
         return _name;
      }
      
      public function get figure() : String
      {
         return var_828;
      }
   }
}
