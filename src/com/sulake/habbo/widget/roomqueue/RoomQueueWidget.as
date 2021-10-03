package com.sulake.habbo.widget.roomqueue
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.widget.RoomWidgetBase;
   import com.sulake.habbo.widget.events.RoomWidgetRoomQueueUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetOpenCatalogMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetRoomQueueMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public class RoomQueueWidget extends RoomWidgetBase
   {
       
      
      private var _window:IFrameWindow;
      
      private var var_1395:String;
      
      private var _config:IHabboConfigurationManager;
      
      private var var_925:Boolean;
      
      private var var_1895:Boolean;
      
      private var var_1394:Boolean;
      
      private var var_926:int;
      
      public function RoomQueueWidget(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboLocalizationManager, param4:IHabboConfigurationManager)
      {
         super(param1,param2,param3);
         _config = param4;
      }
      
      private function changeQueue(param1:WindowMouseEvent) : void
      {
         var _loc2_:* = null;
         if(messageListener == null)
         {
            return;
         }
         if(var_1395 == RoomWidgetRoomQueueUpdateEvent.const_317)
         {
            _loc2_ = new RoomWidgetRoomQueueMessage(RoomWidgetRoomQueueMessage.const_518);
         }
         else
         {
            _loc2_ = new RoomWidgetRoomQueueMessage(RoomWidgetRoomQueueMessage.const_622);
         }
         messageListener.processWidgetMessage(_loc2_);
         removeWindow();
      }
      
      private function onQueueStatus(param1:RoomWidgetRoomQueueUpdateEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.isActive)
         {
            var_1395 = param1.type;
            var_925 = false;
            var_926 = param1.position;
         }
         else
         {
            var_925 = true;
         }
         var_1895 = param1.hasHabboClub;
         var_1394 = param1.isClubQueue;
         localizations.registerParameter("room.queue.position","position",var_926.toString());
         localizations.registerParameter("room.queue.position.hc","position",var_926.toString());
         localizations.registerParameter("room.queue.spectator.position","position",var_926.toString());
         localizations.registerParameter("room.queue.spectator.position.hc","position",var_926.toString());
         showInterface();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetRoomQueueUpdateEvent.const_317,onQueueStatus);
         param1.addEventListener(RoomWidgetRoomQueueUpdateEvent.const_347,onQueueStatus);
         super.registerUpdateEvents(param1);
      }
      
      private function createWindow() : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(_window != null)
         {
            return true;
         }
         var _loc1_:XmlAsset = assets.getAssetByName("room_queue") as XmlAsset;
         _window = windowManager.buildFromXML(_loc1_.content as XML) as IFrameWindow;
         if(_window == null)
         {
            return false;
         }
         _window.visible = false;
         var _loc2_:IBitmapWrapperWindow = _window.findChildByName("club_icon") as IBitmapWrapperWindow;
         if(_loc2_ != null)
         {
            _loc4_ = assets.getAssetByName("hc_logo") as BitmapDataAsset;
            if(_loc4_ != null)
            {
               _loc5_ = new BitmapData(_loc2_.width,_loc2_.height);
               _loc6_ = _loc4_.content as BitmapData;
               if(_loc6_ != null)
               {
                  _loc5_.copyPixels(_loc6_,_loc6_.rect,new Point(0,0));
                  _loc2_.bitmap = _loc5_;
               }
            }
         }
         var _loc3_:IWindow = _window.findChildByTag("close");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,exitQueue);
         }
         _loc3_ = _window.findChildByName("cancel_button");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,exitQueue);
         }
         _loc3_ = _window.findChildByName("link_text");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,openLink);
         }
         _loc3_ = _window.findChildByName("change_button");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,changeQueue);
         }
         _window.center();
         return true;
      }
      
      private function removeWindow() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function exitQueue(param1:WindowMouseEvent) : void
      {
         if(messageListener == null)
         {
            return;
         }
         var _loc2_:RoomWidgetRoomQueueMessage = new RoomWidgetRoomQueueMessage(RoomWidgetRoomQueueMessage.const_554);
         messageListener.processWidgetMessage(_loc2_);
         removeWindow();
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetRoomQueueUpdateEvent.const_317,onQueueStatus);
         param1.removeEventListener(RoomWidgetRoomQueueUpdateEvent.const_347,onQueueStatus);
      }
      
      override public function dispose() : void
      {
         removeWindow();
         _config = null;
         super.dispose();
      }
      
      private function openLink(param1:WindowMouseEvent) : void
      {
         messageListener.processWidgetMessage(new RoomWidgetOpenCatalogMessage(RoomWidgetOpenCatalogMessage.const_420));
      }
      
      private function showInterface() : void
      {
         if(!createWindow())
         {
            return;
         }
         var _loc1_:ITextWindow = _window.findChildByName("info_text") as ITextWindow;
         var _loc2_:IButtonWindow = _window.findChildByName("change_button") as IButtonWindow;
         var _loc3_:IWindow = _window.findChildByName("spectator_info");
         if(_loc1_ != null && _loc2_ != null && _loc3_ != null)
         {
            switch(var_1395)
            {
               case RoomWidgetRoomQueueUpdateEvent.const_317:
                  _loc1_.caption = !!var_1394 ? "${room.queue.position.hc}" : "${room.queue.position}";
                  _loc2_.caption = "${room.queue.spectatormode}";
                  _loc3_.visible = var_925;
                  break;
               case RoomWidgetRoomQueueUpdateEvent.const_347:
                  _loc1_.caption = !!var_1394 ? "${room.queue.spectator.position.hc}" : "${room.queue.spectator.position}";
                  _loc2_.caption = "${room.queue.back}";
                  _loc3_.visible = false;
            }
            _loc2_.visible = var_925;
         }
         var _loc4_:IWindowContainer = _window.findChildByName("club_container") as IWindowContainer;
         if(_loc4_ != null)
         {
            _loc4_.visible = !var_1895;
         }
         _window.visible = true;
      }
   }
}
