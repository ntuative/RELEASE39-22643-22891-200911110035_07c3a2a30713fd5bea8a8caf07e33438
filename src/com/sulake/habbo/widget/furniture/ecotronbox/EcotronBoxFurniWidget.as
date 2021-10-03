package com.sulake.habbo.widget.furniture.ecotronbox
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.widget.RoomWidgetBase;
   import com.sulake.habbo.widget.events.RoomWidgetEcotronBoxDataUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetPresentDataUpdateEvent;
   import com.sulake.habbo.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetEcotronBoxOpenMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class EcotronBoxFurniWidget extends RoomWidgetBase
   {
      
      private static const const_972:Number = 100;
      
      private static const const_971:Number = 100;
       
      
      private var var_222:Boolean = false;
      
      private var _window:IWindowContainer;
      
      private var var_197:String;
      
      private var var_154:int = -1;
      
      private var _controller:Boolean;
      
      public function EcotronBoxFurniWidget(param1:IHabboWindowManager, param2:IAssetLibrary = null)
      {
         super(param1,param2);
      }
      
      private function onPresentUpdate(param1:RoomWidgetPresentDataUpdateEvent) : void
      {
         switch(param1.type)
         {
            case RoomWidgetPresentDataUpdateEvent.const_57:
               hideInterface();
         }
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetEcotronBoxDataUpdateEvent.const_57,onObjectUpdate);
         param1.addEventListener(RoomWidgetEcotronBoxDataUpdateEvent.const_76,onObjectUpdate);
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_122,onRoomObjectRemoved);
         param1.addEventListener(RoomWidgetPresentDataUpdateEvent.const_57,onPresentUpdate);
         super.registerUpdateEvents(param1);
      }
      
      private function showIcon(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            param1 = new BitmapData(1,1);
         }
         if(_window == null)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = _window.findChildByName("ecotronbox_card_preview") as IBitmapWrapperWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = (_loc2_.width - param1.width) / 2;
         var _loc4_:int = (_loc2_.height - param1.height) / 2;
         if(_loc2_.bitmap == null)
         {
            _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,16777215);
         }
         _loc2_.bitmap.fillRect(_loc2_.bitmap.rect,16777215);
         _loc2_.bitmap.copyPixels(param1,param1.rect,new Point(_loc3_,_loc4_),null,null,false);
      }
      
      private function hideInterface() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(!var_222)
         {
            var_154 = -1;
         }
         var_197 = "";
         _controller = false;
      }
      
      private function setOpenButton(param1:Boolean) : void
      {
         var _loc2_:* = null;
         if(_window == null)
         {
            return;
         }
         _loc2_ = _window.findChildByName("ecotronbox_card_btn_open");
         if(_loc2_ != null)
         {
            if(_controller && param1)
            {
               _loc2_.visible = true;
               _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onMouseEvent);
            }
            else
            {
               _loc2_.visible = false;
            }
         }
      }
      
      override public function dispose() : void
      {
         hideInterface();
         super.dispose();
      }
      
      private function onObjectUpdate(param1:RoomWidgetEcotronBoxDataUpdateEvent) : void
      {
         hideInterface();
         switch(param1.type)
         {
            case RoomWidgetEcotronBoxDataUpdateEvent.const_57:
               var_222 = false;
               var_154 = param1.objectId;
               var_197 = param1.text;
               _controller = param1.method_1;
               showInterface();
               break;
            case RoomWidgetEcotronBoxDataUpdateEvent.const_76:
               if(!var_222)
               {
                  return;
               }
               var_154 = param1.objectId;
               showInterface();
               showIcon(param1.iconBitmapData);
               showDescription(param1.text);
               setOpenButton(false);
               break;
         }
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetEcotronBoxDataUpdateEvent.const_57,onObjectUpdate);
         param1.removeEventListener(RoomWidgetEcotronBoxDataUpdateEvent.const_76,onObjectUpdate);
         param1.removeEventListener(RoomWidgetPresentDataUpdateEvent.const_57,onPresentUpdate);
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_122,onRoomObjectRemoved);
      }
      
      private function onRoomObjectRemoved(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         if(param1.id == var_154)
         {
            hideInterface();
         }
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "ecotronbox_card_btn_open":
               sendOpen();
               break;
            case "ecotronbox_card_btn_close":
            default:
               var_222 = false;
               hideInterface();
         }
      }
      
      private function sendOpen() : void
      {
         var _loc1_:* = null;
         if(var_222 || var_154 == -1 || !_controller)
         {
            return;
         }
         var_222 = true;
         if(messageListener != null)
         {
            _loc1_ = new RoomWidgetEcotronBoxOpenMessage(RoomWidgetEcotronBoxOpenMessage.const_520,var_154);
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      private function showInterface() : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         if(var_154 < 0)
         {
            return;
         }
         var _loc1_:IAsset = assets.getAssetByName("ecotronbox_card");
         var _loc2_:XmlAsset = XmlAsset(_loc1_);
         if(_loc2_ == null)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _window = windowManager.createWindow("ecotronboxcardui_container","",HabboWindowType.const_53,HabboWindowStyle.const_37,0 | 0,new Rectangle(const_972,const_971,2,2),null,0) as IWindowContainer;
         _window.buildFromXML(XML(_loc2_.content));
         _loc3_ = assets.getAssetByName("ecotronbox_card_bg") as BitmapDataAsset;
         _loc5_ = _window.findChildByName("ecotronbox_card_bg") as IBitmapWrapperWindow;
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.content as BitmapData;
            _loc5_.bitmap = _loc4_.clone();
         }
         _loc6_ = _window.findChildByName("ecotronbox_card_date") as ITextWindow;
         if(_loc6_ != null && var_197 != null)
         {
            _loc6_.caption = var_197;
         }
         _loc7_ = _window.findChildByName("ecotronbox_card_btn_close");
         if(_loc7_ != null)
         {
            _loc7_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onMouseEvent);
         }
         setOpenButton(true);
      }
      
      private function showDescription(param1:String) : void
      {
         var _loc2_:* = null;
         _loc2_ = _window.findChildByName("ecotronbox_card_msg") as ITextWindow;
         if(_loc2_ != null && param1 != null)
         {
            _loc2_.caption = param1;
         }
      }
   }
}
