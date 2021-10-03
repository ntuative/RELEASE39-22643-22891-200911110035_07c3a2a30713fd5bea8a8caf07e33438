package com.sulake.habbo.widget
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.events.EventDispatcher;
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   
   public class RoomWidgetBase implements IRoomWidget
   {
       
      
      private var var_117:IRoomWidgetMessageListener;
      
      private var _assets:IAssetLibrary;
      
      private var _windowManager:IHabboWindowManager;
      
      private var name_1:EventDispatcher;
      
      private var _localizations:IHabboLocalizationManager;
      
      public function RoomWidgetBase(param1:IHabboWindowManager, param2:IAssetLibrary = null, param3:IHabboLocalizationManager = null)
      {
         super();
         _windowManager = param1;
         _assets = param2;
         _localizations = param3;
      }
      
      public function get assets() : IAssetLibrary
      {
         return _assets;
      }
      
      public function get mainWindow() : IWindow
      {
         return null;
      }
      
      public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 is EventDispatcher)
         {
            name_1 = param1 as EventDispatcher;
         }
      }
      
      public function set messageListener(param1:IRoomWidgetMessageListener) : void
      {
         var_117 = param1;
      }
      
      public function get messageListener() : IRoomWidgetMessageListener
      {
         return var_117;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
      }
      
      public function dispose() : void
      {
         var_117 = null;
         _windowManager = null;
         if(name_1 != null && true)
         {
            unregisterUpdateEvents(name_1);
         }
         name_1 = null;
         _assets = null;
         _localizations = null;
      }
      
      public function get localizations() : IHabboLocalizationManager
      {
         return _localizations;
      }
   }
}
