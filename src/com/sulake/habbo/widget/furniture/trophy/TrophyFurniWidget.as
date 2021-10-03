package com.sulake.habbo.widget.furniture.trophy
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.widget.RoomWidgetBase;
   import com.sulake.habbo.widget.events.RoomWidgetTrophyDataUpdateEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   
   public class TrophyFurniWidget extends RoomWidgetBase
   {
      
      private static const const_1300:Array = new Array("gold","silver","bronze");
      
      private static const const_972:Number = 100;
      
      private static const const_971:Number = 100;
       
      
      private var _color:Number;
      
      private var _name:String;
      
      private var var_569:String;
      
      private var _message:String = null;
      
      private var _window:IFrameWindow;
      
      public function TrophyFurniWidget(param1:IHabboWindowManager, param2:IAssetLibrary = null)
      {
         super(param1,param2);
         this.mainWindow;
         hideInterface();
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetTrophyDataUpdateEvent.const_640,onObjectUpdate);
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         hideInterface();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetTrophyDataUpdateEvent.const_640,onObjectUpdate);
         super.registerUpdateEvents(param1);
      }
      
      private function onObjectUpdate(param1:RoomWidgetTrophyDataUpdateEvent) : void
      {
         hideInterface();
         _name = param1.name;
         var_569 = param1.date;
         _message = param1.message;
         _color = param1.color;
         showInterface();
      }
      
      override public function get mainWindow() : IWindow
      {
         var _loc1_:* = null;
         if(_window == null)
         {
            _loc1_ = assets.getAssetByName("trophy") as XmlAsset;
            if(_loc1_ == null)
            {
               return null;
            }
            _window = windowManager.buildFromXML(_loc1_.content as XML) as IFrameWindow;
         }
         return _window;
      }
      
      private function hideInterface() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      private function showInterface() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:IFrameWindow = this.mainWindow as IFrameWindow;
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = _loc1_.findChildByTag("close");
         if(_loc2_ != null)
         {
            _loc2_.procedure = onWindowClose;
         }
         _loc3_ = _loc1_.findChildByName("greeting") as ITextWindow;
         if(_loc3_ != null)
         {
            _message = _message.replace(/\\r/g,"\n");
            _loc3_.text = _message;
            _loc3_.procedure = onWindowClose;
         }
         _loc3_ = _loc1_.findChildByName("date") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = var_569;
         }
         _loc3_ = _loc1_.findChildByName("name") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = _name;
         }
         _loc1_.visible = true;
      }
      
      override public function dispose() : void
      {
         hideInterface();
         super.dispose();
      }
   }
}
