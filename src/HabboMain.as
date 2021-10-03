package
{
   import com.sulake.core.Core;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ICore;
   import com.sulake.core.runtime.ICoreConfigStatusListener;
   import com.sulake.habbo.tracking.HabboLoginTrackingStep;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   
   public class HabboMain extends Sprite implements IHabboMain
   {
       
      
      private var var_666:ICore;
      
      private var var_1445:ICoreConfigStatusListener;
      
      public function HabboMain(param1:ICoreConfigStatusListener)
      {
         super();
         var_1445 = param1;
         addEventListener(Event.ADDED_TO_STAGE,onStageInit);
         Logger.log("Core version: undefined");
      }
      
      private function initCore(param1:String, param2:uint) : void
      {
         trackLoginStep(HabboLoginTrackingStep.const_13);
         var_666 = Core.instantiate(this,param2);
         initBakedInComponents();
         var_666.events.addEventListener(Component.COMPONENT_EVENT_ERROR,onCoreError);
         var_666.loadExternalConfigDocument(new URLRequest(param1),var_1445);
      }
      
      public function onCoreError(param1:Event) : void
      {
         trackLoginStep(HabboLoginTrackingStep.const_24);
      }
      
      protected function onStageInit(param1:Event = null) : void
      {
         Logger.log("Player version: undefined");
         initCore("config_habbo.xml",Core.const_755);
      }
      
      public function initializeCore() : void
      {
         var_666.initialize();
      }
      
      private function prepareAssetLibrary(param1:Class) : void
      {
         var xmlClass:Class = null;
         var resource:Class = param1;
         try
         {
            xmlClass = (resource as Object).manifest as Class;
            if(xmlClass == null)
            {
               return;
            }
         }
         catch(e:Error)
         {
            Logger.log("Failed to find embedded manifest.xml in " + resource + "!");
            return;
         }
         var bytes:ByteArray = new xmlClass() as ByteArray;
         var manifest:XML = new XML(bytes.readUTFBytes(bytes.length));
         var_666.prepareAssetLibrary(manifest,resource);
      }
      
      private function prepareBakedInComponent(param1:Class) : void
      {
         var xmlClass:Class = null;
         var resource:Class = param1;
         try
         {
            xmlClass = (resource as Object).manifest as Class;
            if(xmlClass == null)
            {
               return;
            }
         }
         catch(e:Error)
         {
            Logger.log("Failed to find embedded manifest.xml in " + resource + "!");
            return;
         }
         var bytes:ByteArray = new xmlClass() as ByteArray;
         var manifest:XML = new XML(bytes.readUTFBytes(bytes.length));
         var_666.prepareComponent(manifest,resource);
      }
      
      private function initBakedInComponents() : void
      {
         prepareBakedInComponent(CoreCommunicationFrameworkLib);
         prepareBakedInComponent(HabboRoomObjectLogicLib);
         prepareBakedInComponent(HabboRoomObjectVisualizationLib);
         prepareBakedInComponent(RoomManagerLib);
         prepareBakedInComponent(RoomSpriteRendererLib);
         prepareBakedInComponent(HabboRoomSessionManagerLib);
         prepareBakedInComponent(HabboAvatarRenderLib);
         prepareBakedInComponent(HabboRoomWidgetLib);
         prepareBakedInComponent(HabboSessionDataManagerLib);
         prepareBakedInComponent(HabboTrackingLib);
         prepareBakedInComponent(HabboConfigurationCom);
         prepareBakedInComponent(HabboLocalizationCom);
         prepareBakedInComponent(HabboWindowManagerCom);
         prepareBakedInComponent(HabboCommunicationCom);
         prepareBakedInComponent(HabboCommunicationDemoCom);
         prepareBakedInComponent(HabboNavigatorCom);
         prepareBakedInComponent(HabboFriendListCom);
         prepareBakedInComponent(HabboMessengerCom);
         prepareBakedInComponent(HabboInventoryCom);
         prepareBakedInComponent(HabboToolbarCom);
         prepareBakedInComponent(HabboCatalogCom);
         prepareBakedInComponent(HabboRoomEngineCom);
         prepareBakedInComponent(HabboRoomUICom);
         prepareBakedInComponent(HabboAvatarEditorCom);
         prepareBakedInComponent(HabboNotificationsCom);
         prepareBakedInComponent(HabboHelpCom);
         prepareBakedInComponent(HabboAdManagerCom);
         prepareBakedInComponent(HabboModerationCom);
         Logger.log("Sound manager embed...");
         Logger.log("Trying to embed Flash 9 version");
         prepareBakedInComponent(HabboSoundManagerCom);
      }
      
      private function trackLoginStep(param1:String) : void
      {
         if(loaderInfo == null)
         {
            return;
         }
         if(loaderInfo.parameters["processlog.enabled"] != "1")
         {
            return;
         }
         Logger.log("* HabboMain Login Step: " + param1);
         if(false)
         {
            ExternalInterface.call("FlashExternalInterface.logLoginStep",param1);
         }
         else
         {
            Logger.log("HabboMain: ExternalInterface is not available, tracking is disabled");
         }
      }
      
      private function getPlayerMajorVersion() : int
      {
         var _loc1_:Array = Capabilities.version.split(",");
         var _loc2_:Array = _loc1_[0].toString().split(" ");
         return int(_loc2_[1].toString());
      }
   }
}
