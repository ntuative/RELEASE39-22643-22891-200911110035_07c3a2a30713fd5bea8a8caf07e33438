package com.sulake.habbo.widget.memenu
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.ICoreWindowManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetDanceMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetOpenCatalogMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetOpenInventoryMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetShowOwnRoomsMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetWaveMessage;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class MeMenuMainView implements IMeMenuView
   {
       
      
      private var _widget:MeMenuWidget;
      
      private var _window:IWindowContainer;
      
      private var var_181:Dictionary;
      
      public function MeMenuMainView()
      {
         super();
         var_181 = new Dictionary();
         var_181["rooms_icon"] = ["gohome_white","gohome_color"];
         var_181["dance_icon"] = ["dance_white","dance_color"];
         var_181["clothes_icon"] = ["clothes_white","clothes_color"];
         var_181["effects_icon"] = ["effects_white","effects_color"];
         var_181["badges_icon"] = ["badges_white","badges_color"];
         var_181["wave_icon"] = ["wave_white","wave_color"];
         var_181["hc_icon"] = ["_white","_color"];
         var_181["settings_icon"] = ["settings_white","settings_color"];
      }
      
      private function getClubAssetNameBase() : String
      {
         if(true)
         {
            return "hc0";
         }
         return "hc" + Math.min(5,Math.floor(0) + 1);
      }
      
      private function setElementImage(param1:String, param2:String, param3:Number = 1) : void
      {
         var _loc4_:IBitmapWrapperWindow = _window.findChildByName(param1) as IBitmapWrapperWindow;
         var _loc5_:BitmapDataAsset = _widget.assets.getAssetByName(param2) as BitmapDataAsset;
         if(_loc4_ == null)
         {
            Logger.log("Could not find element: " + param1);
            return;
         }
         if(_loc5_ == null || _loc5_.content == null)
         {
            Logger.log("Could not find asset: " + param2);
            return;
         }
         var _loc6_:BitmapData = _loc5_.content as BitmapData;
         _loc4_.bitmap = new BitmapData(_loc4_.width,_loc4_.height,true,0);
         _loc4_.bitmap.copyPixels(_loc6_,_loc6_.rect,new Point(0,0));
         _loc4_.blend = param3;
      }
      
      private function setElementText(param1:String, param2:String) : void
      {
         var _loc3_:ITextWindow = _window.findChildByName(param1) as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = param2;
         }
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      private function onAlertClicked(param1:IAlertDialog, param2:Event) : void
      {
         param1.dispose();
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = NaN;
         if(_widget == null)
         {
            return;
         }
         var _loc2_:XmlAsset = _widget.assets.getAssetByName("memenu_main") as XmlAsset;
         Logger.log("Show window: " + _loc2_);
         _window = (_widget.windowManager as ICoreWindowManager).buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _window.name = param1;
         for(_loc3_ in var_181)
         {
            _loc6_ = var_181[_loc3_];
            if(!(_loc6_ == null || _loc6_.length == 0))
            {
               _loc7_ = _loc6_[0];
               _loc8_ = 1;
               switch(_loc3_)
               {
                  case "dance_icon":
                  case "wave_icon":
                     if(false)
                     {
                        _loc8_ = 0.5;
                     }
                     break;
                  case "effects_icon":
                     if(false)
                     {
                        _loc8_ = 0.5;
                     }
                     break;
                  case "hc_icon":
                     _loc7_ = getClubAssetNameBase() + _loc7_;
                     if(true)
                     {
                        setElementText("hc_text",_widget.localizations.getKey("widget.memenu.hc.join"));
                     }
                     else if(false)
                     {
                        _widget.localizations.registerParameter("widget.memenu.hc.long","days",String(_widget.habboClubDays));
                        _widget.localizations.registerParameter("widget.memenu.hc.long","months",String(_widget.habboClubPeriods));
                        setElementText("hc_text",_widget.localizations.getKey("widget.memenu.hc.long"));
                     }
                     else
                     {
                        _widget.localizations.registerParameter("widget.memenu.hc","days",String(_widget.habboClubDays));
                        setElementText("hc_text",_widget.localizations.getKey("widget.memenu.hc"));
                     }
               }
               setElementImage(_loc3_,_loc7_,_loc8_);
            }
         }
         _loc5_ = 0;
         while(_loc5_ < _window.numChildren)
         {
            _loc4_ = _window.getChildAt(_loc5_);
            _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onButtonClicked);
            _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,onMouseOver);
            _loc4_.addEventListener(WindowMouseEvent.const_29,onMouseOut);
            _loc5_++;
         }
         _widget.mainContainer.addChild(_window);
      }
      
      public function init(param1:MeMenuWidget, param2:String) : void
      {
         _widget = param1;
         createWindow(param2);
      }
      
      private function onResized(param1:WindowEvent) : void
      {
         _window.x = 0;
         _window.y = 0;
      }
      
      private function onMouseOut(param1:WindowMouseEvent) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc3_:IWindow = param1.target as IWindow;
         var _loc4_:String = _loc3_.name;
         switch(_loc4_)
         {
            case "dance":
            case "wave":
               if(false)
               {
                  return;
               }
            case "effects":
               if(false)
               {
                  return;
               }
            case "rooms":
            case "badges":
            case "clothes":
            case "settings":
               _loc5_ = _loc4_ + "_icon";
               _loc6_ = var_181[_loc5_];
               if(_loc6_ != null)
               {
                  _loc7_ = _loc6_[0];
                  setElementImage(_loc5_,_loc7_);
               }
               break;
            case "hc":
               _loc5_ = _loc4_ + "_icon";
               _loc6_ = var_181[_loc5_];
               if(_loc6_ != null)
               {
                  _loc7_ = getClubAssetNameBase() + _loc6_[0];
                  setElementImage(_loc5_,_loc7_);
               }
         }
      }
      
      private function onMouseOver(param1:WindowMouseEvent) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc3_:IWindow = param1.target as IWindow;
         var _loc4_:String = _loc3_.name;
         switch(_loc4_)
         {
            case "dance":
            case "wave":
               if(false)
               {
                  return;
               }
            case "effects":
               if(false)
               {
                  return;
               }
            case "rooms":
            case "badges":
            case "clothes":
            case "settings":
               _loc5_ = _loc4_ + "_icon";
               _loc6_ = var_181[_loc5_];
               if(_loc6_ != null)
               {
                  _loc7_ = _loc6_[1];
                  setElementImage(_loc5_,_loc7_);
               }
               break;
            case "hc":
               _loc5_ = _loc4_ + "_icon";
               _loc6_ = var_181[_loc5_];
               if(_loc6_ != null)
               {
                  _loc7_ = getClubAssetNameBase() + _loc6_[1];
                  setElementImage(_loc5_,_loc7_);
               }
         }
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc3_:IWindow = param1.target as IWindow;
         var _loc4_:String = _loc3_.name;
         switch(_loc4_)
         {
            case "dance":
               if(false)
               {
                  return;
               }
               _widget.changeView(MeMenuWidget.const_749);
               break;
            case "wave":
               if(false)
               {
                  return;
               }
               if(false)
               {
                  _widget.messageListener.processWidgetMessage(new RoomWidgetDanceMessage(RoomWidgetDanceMessage.const_866));
                  _widget.isDancing = false;
               }
               _widget.messageListener.processWidgetMessage(new RoomWidgetWaveMessage());
               _widget.hide();
               break;
            case "effects":
               if(false)
               {
                  return;
               }
               _widget.changeView(MeMenuWidget.const_574);
               break;
            case "rooms":
               _widget.messageListener.processWidgetMessage(new RoomWidgetShowOwnRoomsMessage());
               _widget.hide();
               break;
            case "badges":
               _widget.messageListener.processWidgetMessage(new RoomWidgetOpenInventoryMessage(RoomWidgetOpenInventoryMessage.const_772));
               _widget.hide();
               break;
            case "clothes":
               _widget.changeView(MeMenuWidget.const_253);
               break;
            case "hc":
               _widget.messageListener.processWidgetMessage(new RoomWidgetOpenCatalogMessage(RoomWidgetOpenCatalogMessage.const_420));
               _widget.hide();
               break;
            case "settings":
               _widget.changeView(MeMenuWidget.const_551);
               break;
            default:
               Logger.log("Me Menu Main View: unknown button: " + _loc4_);
         }
      }
      
      public function dispose() : void
      {
         _widget = null;
         _window.dispose();
         _window = null;
      }
   }
}
