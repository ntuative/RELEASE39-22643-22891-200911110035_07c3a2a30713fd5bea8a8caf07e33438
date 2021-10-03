package com.sulake.habbo.notifications
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ParkBusDialogManager
   {
       
      
      private var _assets:IAssetLibrary;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _window:IFrameWindow;
      
      private var _localization:IHabboLocalizationManager;
      
      public function ParkBusDialogManager(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboLocalizationManager)
      {
         super();
         _assets = param2;
         _localization = param3;
         _windowManager = param1;
      }
      
      public function handleParkBusCannotEnter(param1:String) : void
      {
         var _loc4_:* = null;
         disposeWindow();
         if(_assets == null || _windowManager == null)
         {
            return;
         }
         var _loc2_:XmlAsset = _assets.getAssetByName("layout_parkbus_notification_xml") as XmlAsset;
         var _loc3_:XML = _loc2_.content as XML;
         _window = _windowManager.buildFromXML(_loc3_) as IFrameWindow;
         _window.center();
         var _loc5_:ITextWindow = _window.findChildByName("hubu_reason") as ITextWindow;
         if(_loc5_ != null)
         {
            _loc5_.text = param1;
         }
         _loc4_ = _window.findChildByName("hubu_link1");
         if(_loc4_ != null)
         {
            _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onLinkClick);
            _loc4_.alphaTreshold = 0;
         }
         _loc4_ = _window.findChildByName("hubu_link2");
         if(_loc4_ != null)
         {
            _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onLinkClick);
            _loc4_.alphaTreshold = 0;
         }
         _loc4_ = _window.findChildByTag("close");
         if(_loc4_ != null)
         {
            _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onLinkClick);
         }
      }
      
      private function openExternalLink(param1:String) : void
      {
         navigateToURL(new URLRequest(param1),"habboMain");
      }
      
      private function disposeWindow(param1:WindowEvent = null) : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onLinkClick(param1:WindowMouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "hubu_link1":
               if(_localization.getKey("hubu.info.url1").length > 0)
               {
                  openExternalLink(_localization.getKey("hubu.info.url1"));
               }
               break;
            case "hubu_link2":
               if(_localization.getKey("hubu.info.url2").length > 0)
               {
                  openExternalLink(_localization.getKey("hubu.info.url2"));
               }
               break;
            case "header_button_close":
               disposeWindow();
         }
      }
      
      public function dispose() : void
      {
         disposeWindow();
         _windowManager = null;
         _assets = null;
      }
   }
}
