package com.sulake.habbo.help
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.help.cfh.data.CallForHelpData;
   import com.sulake.habbo.help.cfh.data.UserRegistry;
   import com.sulake.habbo.help.enum.HabboHelpViewEnum;
   import com.sulake.habbo.help.help.data.FaqIndex;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboToolbar;
   import flash.utils.Dictionary;
   import iid.IIDHabboWindowManager;
   
   public class HabboHelp extends Component implements IHabboHelp
   {
       
      
      private var _view:HelpUI;
      
      private var var_1483:UserRegistry;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var var_1247:IHabboLocalizationManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_1246:IHabboConfigurationManager;
      
      private var var_198:IHabboToolbar;
      
      private var var_735:IHabboCommunicationManager;
      
      private var var_680:FaqIndex;
      
      private var var_1245:IncomingMessages;
      
      private var var_997:CallForHelpData;
      
      public function HabboHelp(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         var_997 = new CallForHelpData();
         var_1483 = new UserRegistry();
         super(param1,param2,param3);
         _assetLibrary = param3;
         var_680 = new FaqIndex();
         queueInterface(new IIDHabboWindowManager(),onWindowManagerReady);
      }
      
      public function tellUI(param1:String, param2:* = null) : void
      {
         if(_view != null)
         {
            _view.tellUI(param1,param2);
         }
      }
      
      private function createUI() : Boolean
      {
         if(_view == null && _assetLibrary != null && _windowManager != null)
         {
            _view = new HelpUI(this,_assetLibrary,_windowManager,var_1247,var_198);
         }
         return _view != null;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      private function onRoomSessionEvent(param1:RoomSessionEvent) : void
      {
         switch(param1.type)
         {
            case RoomSessionEvent.const_86:
               if(_view != null)
               {
                  _view.setRoomSessionStatus(true);
               }
               break;
            case RoomSessionEvent.const_97:
               if(_view != null)
               {
                  _view.setRoomSessionStatus(false);
               }
               userRegistry.unregisterRoom();
         }
      }
      
      public function reportUser(param1:int, param2:String) : void
      {
         var_997.reportedUserId = param1;
         var_997.reportedUserName = param2;
         _view.showUI(HabboHelpViewEnum.const_293);
      }
      
      private function setHabboToolbarIcon() : void
      {
         if(var_198 != null)
         {
            var_198.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.const_101,HabboToolbarIconEnum.HELP));
         }
      }
      
      public function enableCallForGuideBotUI() : void
      {
         if(_view != null)
         {
            _view.updateCallForGuideBotUI(true);
         }
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return var_1247;
      }
      
      public function showCallForHelpResult(param1:String) : void
      {
         if(_view != null)
         {
            _view.showCallForHelpResult(param1);
         }
      }
      
      private function onLocalizationManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var_1247 = IHabboLocalizationManager(param2);
         queueInterface(new IIDHabboConfigurationManager(),onConfigurationManagerReady);
      }
      
      public function get userRegistry() : UserRegistry
      {
         return var_1483;
      }
      
      public function get callForHelpData() : CallForHelpData
      {
         return var_997;
      }
      
      override public function dispose() : void
      {
         if(_view != null)
         {
            _view.dispose();
            _view = null;
         }
         var_1245 = null;
         if(var_680 != null)
         {
            var_680.dispose();
            var_680 = null;
         }
         if(_windowManager)
         {
            _windowManager.release(new IIDHabboWindowManager());
            _windowManager = null;
         }
         super.dispose();
      }
      
      private function onWindowManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _windowManager = IHabboWindowManager(param2);
         queueInterface(new IIDHabboCommunicationManager(),onCommunicationManagerReady);
      }
      
      private function onCommunicationManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var_735 = IHabboCommunicationManager(param2);
         var_1245 = new IncomingMessages(this,var_735);
         queueInterface(new IIDHabboToolbar(),onToolbarReady);
      }
      
      public function showUI(param1:String = null) : void
      {
         if(_view != null)
         {
            _view.showUI(param1);
         }
      }
      
      public function sendMessage(param1:IMessageComposer) : void
      {
         if(var_735 != null && param1 != null)
         {
            var_735.getHabboMainConnection(null).send(param1);
         }
      }
      
      public function getFaq() : FaqIndex
      {
         return var_680;
      }
      
      private function onToolbarReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var_198 = IHabboToolbar(param2);
         queueInterface(new IIDHabboLocalizationManager(),onLocalizationManagerReady);
      }
      
      private function toggleUI() : void
      {
         if(_view == null)
         {
            if(!createUI())
            {
               return;
            }
         }
         _view.toggleUI();
      }
      
      public function disableCallForGuideBotUI() : void
      {
         if(_view != null)
         {
            _view.updateCallForGuideBotUI(false);
         }
      }
      
      private function onConfigurationManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var_1246 = IHabboConfigurationManager(param2);
         queueInterface(new IIDHabboRoomSessionManager(),onRoomSessionManagerReady);
      }
      
      private function onRoomSessionManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var _loc3_:IRoomSessionManager = IRoomSessionManager(param2);
         _loc3_.events.addEventListener(RoomSessionEvent.const_86,onRoomSessionEvent);
         _loc3_.events.addEventListener(RoomSessionEvent.const_97,onRoomSessionEvent);
         var_198.events.addEventListener(HabboToolbarEvent.const_78,onHabboToolbarEvent);
         var_198.events.addEventListener(HabboToolbarEvent.const_55,onHabboToolbarEvent);
         createUI();
         setHabboToolbarIcon();
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == HabboToolbarEvent.const_78)
         {
            setHabboToolbarIcon();
            return;
         }
         if(param1.type == HabboToolbarEvent.const_55)
         {
            if(param1.iconId == HabboToolbarIconEnum.HELP)
            {
               toggleUI();
               return;
            }
         }
      }
      
      public function showCallForHelpReply(param1:String) : void
      {
         if(_view != null)
         {
            _view.showCallForHelpReply(param1);
         }
      }
      
      public function getConfigurationKey(param1:String, param2:String = null, param3:Dictionary = null) : String
      {
         if(var_1246 == null)
         {
            return param1;
         }
         return var_1246.getKey(param1,param2,param3);
      }
   }
}
