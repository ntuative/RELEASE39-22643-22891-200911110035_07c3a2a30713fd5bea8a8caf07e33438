package com.sulake.habbo.widget.memenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.widget.messages.RoomWidgetDanceMessage;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import flash.events.Event;
   
   public class MeMenuDanceView implements IMeMenuView
   {
       
      
      private var _widget:MeMenuWidget;
      
      private var _habboClubRequired:Array;
      
      private var _window:IWindowContainer;
      
      public function MeMenuDanceView()
      {
         _habboClubRequired = [2,3,4];
         super();
      }
      
      private function onAlertClicked(param1:IAlertDialog, param2:Event) : void
      {
         param1.dispose();
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
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc3_:IWindow = param1.target as IWindow;
         _loc4_ = _loc3_.name;
         switch(_loc4_)
         {
            case "dance_1_button":
            case "dance_2_button":
            case "dance_3_button":
            case "dance_4_button":
               _loc5_ = _loc4_.split("_");
               _loc6_ = parseInt(_loc5_[1]);
               _widget.messageListener.processWidgetMessage(new RoomWidgetDanceMessage(_loc6_));
               _widget.isDancing = true;
               _widget.hide();
               break;
            case "stop_dancing_button":
               _widget.messageListener.processWidgetMessage(new RoomWidgetDanceMessage(RoomWidgetDanceMessage.const_866));
               _widget.isDancing = false;
               _widget.hide();
               break;
            case "back_btn":
               _widget.changeView(MeMenuWidget.const_153);
               break;
            default:
               Logger.log("Me Menu Dance View: unknown button: " + _loc4_);
         }
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Boolean = false;
         var _loc10_:* = null;
         var _loc2_:XmlAsset = _widget.assets.getAssetByName("memenu_dance") as XmlAsset;
         Logger.log("Me Menu Dance View: " + _loc2_);
         _window = _widget.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _window.name = param1;
         var _loc3_:* = [];
         _loc3_.push(_window.findChildByName("stop_dancing_button"));
         _loc3_.push(_window.findChildByName("back_btn"));
         for each(_loc10_ in _loc3_)
         {
            if(_loc10_ != null)
            {
               _loc10_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onButtonClicked);
            }
         }
         _loc4_ = _window.findChildByName("buttonContainer") as IItemListWindow;
         _loc5_ = _widget.assets.getAssetByName("memenu_dance_button") as XmlAsset;
         if(_loc4_ != null)
         {
            _loc7_ = 1;
            while(_loc7_ <= 4)
            {
               _loc8_ = _loc7_;
               _loc9_ = false;
               if(RoomWidgetDanceMessage.const_1218.indexOf(_loc8_) >= 0)
               {
                  _loc9_ = false;
               }
               else
               {
                  _loc9_ = true;
               }
               if(_loc9_)
               {
                  _loc10_ = _widget.windowManager.buildFromXML(_loc5_.content as XML) as IWindow;
                  _loc10_.name = "dance_" + _loc7_ + "_button";
                  _loc10_.caption = "${widget.memenu.dance" + _loc7_ + "}";
                  _loc10_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onButtonClicked);
                  _loc4_.addListItemAt(_loc10_,_loc4_.numListItems - 1);
                  if(false)
                  {
                     _loc10_.disable();
                  }
                  else
                  {
                     _loc10_.enable();
                  }
               }
               _loc7_++;
            }
         }
         var _loc6_:IWindow = _window.findChildByName("club_info");
         if(_loc6_ != null && false)
         {
            _loc6_.visible = false;
         }
         _widget.mainContainer.addChild(_window);
      }
      
      public function dispose() : void
      {
         _widget = null;
         _window.dispose();
         _window = null;
      }
   }
}
