package com.sulake.habbo.widget.furniture.placeholder
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.widget.RoomWidgetBase;
   import com.sulake.habbo.widget.events.RoomWidgetShowPlaceholderEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   
   public class PlaceholderWidget extends RoomWidgetBase
   {
       
      
      private var _view:PlaceholderView;
      
      public function PlaceholderWidget(param1:IHabboWindowManager, param2:IAssetLibrary = null, param3:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3);
      }
      
      private function onShowEvent(param1:RoomWidgetShowPlaceholderEvent) : void
      {
         showInterface();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetShowPlaceholderEvent.const_525,onShowEvent);
         super.registerUpdateEvents(param1);
      }
      
      override public function dispose() : void
      {
         if(_view != null)
         {
            _view.dispose();
            _view = null;
         }
         super.dispose();
      }
      
      private function hideInterface() : void
      {
         if(_view != null)
         {
            _view.dispose();
            _view = null;
         }
      }
      
      private function showInterface() : void
      {
         if(_view == null)
         {
            _view = new PlaceholderView(assets,windowManager);
         }
         _view.showWindow();
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetShowPlaceholderEvent.const_525,onShowEvent);
      }
   }
}
