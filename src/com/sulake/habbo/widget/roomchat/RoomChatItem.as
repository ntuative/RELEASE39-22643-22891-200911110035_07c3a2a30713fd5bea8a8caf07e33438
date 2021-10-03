package com.sulake.habbo.widget.roomchat
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.widget.events.RoomWidgetChatUpdateEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomChatItem
   {
      
      private static const const_471:int = 6;
      
      private static const const_331:int = 10;
      
      private static const const_1044:Number = 18;
      
      private static const const_1312:Number = 10;
      
      private static const const_1313:Number = 8;
       
      
      private var var_1175:Number;
      
      private var _assetLibrary:IAssetLibrary;
      
      private var var_937:int;
      
      private var var_637:int;
      
      private var var_100:IRegionWindow;
      
      private var _window:IWindowContainer;
      
      private var var_1086:int;
      
      private var var_1176:Boolean = false;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_1935:int = 0;
      
      private var var_1934:int = -1;
      
      private var _id:String;
      
      private var _width:Number = 0;
      
      private var _message:String;
      
      private var var_376:Number = 0;
      
      private var _height:Number = 0;
      
      private var _roomCategory:int;
      
      private var _widget:RoomChatWidget;
      
      private var var_195:BitmapData;
      
      private var var_939:uint;
      
      private var var_938:int;
      
      private var _roomId:int;
      
      private var var_88:Number = 0;
      
      private var _y:Number = 0;
      
      private var _localizations:IHabboLocalizationManager;
      
      private var var_936:String;
      
      public function RoomChatItem(param1:RoomChatWidget, param2:IHabboWindowManager, param3:IAssetLibrary, param4:String, param5:IHabboLocalizationManager)
      {
         var_936 = new String();
         _message = new String();
         super();
         _widget = param1;
         _windowManager = param2;
         _assetLibrary = param3;
         _id = param4;
         _height = const_1044;
         _localizations = param5;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function disableTooltip() : void
      {
         if(var_100 != null)
         {
            var_100.toolTipCaption = "";
         }
      }
      
      public function set senderX(param1:Number) : void
      {
         var_1175 = param1;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      private function onBubbleMouseOut(param1:WindowMouseEvent) : void
      {
         _widget.onItemMouseOut(var_937,var_938,_roomId,_roomCategory,param1);
      }
      
      private function onBubbleMouseClick(param1:WindowMouseEvent) : void
      {
         _widget.onItemMouseClick(var_937,var_938,_roomId,_roomCategory,param1);
      }
      
      public function enableTooltip() : void
      {
         if(var_100 != null)
         {
            var_100.toolTipCaption = "${chat.history.drag.tooltip}";
            var_100.toolTipDelay = 500;
         }
      }
      
      public function get x() : Number
      {
         return var_88;
      }
      
      public function get timestamp() : int
      {
         return var_1086;
      }
      
      public function get height() : Number
      {
         return _height;
      }
      
      public function hideView() : void
      {
         if(_window != null)
         {
            _window.dispose();
         }
         _window = null;
         var_1176 = false;
      }
      
      public function hidePointer() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:IBitmapWrapperWindow = _window.findChildByName("pointer") as IBitmapWrapperWindow;
         _loc1_.visible = false;
      }
      
      public function set y(param1:Number) : void
      {
         _y = param1;
         if(_window != null)
         {
            _window.y = param1 - var_376;
         }
      }
      
      public function get view() : IWindowContainer
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(var_100 != null)
         {
            var_100.dispose();
            var_100 = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
            _widget = null;
         }
      }
      
      public function define(param1:RoomWidgetChatUpdateEvent) : void
      {
         var_637 = param1.chatType;
         var_937 = param1.userId;
         var_936 = param1.userName;
         var_938 = param1.userCategory;
         _message = param1.text;
         var_1175 = param1.userX;
         var_195 = param1.userImage;
         var_939 = param1.userColor;
         _roomId = param1.roomId;
         _roomCategory = param1.roomCategory;
         renderView();
      }
      
      public function checkOverlap(param1:Number, param2:Number, param3:Number, param4:Number) : Boolean
      {
         var _loc5_:Rectangle = new Rectangle(var_88,_y,width,_height);
         var _loc6_:Rectangle = new Rectangle(param1,param2,param3,param4);
         return _loc5_.intersects(_loc6_);
      }
      
      public function get senderX() : Number
      {
         return var_1175;
      }
      
      public function set timestamp(param1:int) : void
      {
         var_1086 = param1;
      }
      
      private function addEventListenerToChild(param1:IWindow) : void
      {
         if(param1 != null)
         {
            param1.setParamFlag(HabboWindowParam.const_34,true);
            param1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onBubbleMouseClick);
            param1.addEventListener(WindowMouseEvent.const_67,onBubbleMouseDown);
            param1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,onBubbleMouseOver);
            param1.addEventListener(WindowMouseEvent.const_29,onBubbleMouseOut);
            param1.addEventListener(WindowMouseEvent.const_109,onBubbleMouseUp);
         }
      }
      
      public function get width() : Number
      {
         return _width;
      }
      
      public function renderView() : void
      {
         var _loc1_:* = null;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         var _loc27_:* = null;
         var _loc28_:* = null;
         var _loc29_:* = null;
         var _loc30_:* = 0;
         var _loc31_:* = 0;
         var _loc32_:* = 0;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:* = null;
         var _loc37_:* = null;
         var _loc38_:* = null;
         if(var_1176)
         {
            return;
         }
         var_1176 = true;
         if(_window != null)
         {
            return;
         }
         switch(var_637)
         {
            case RoomWidgetChatUpdateEvent.const_121:
               _loc1_ = "bubble_speak";
               break;
            case RoomWidgetChatUpdateEvent.const_98:
               _loc1_ = "bubble_whisper";
               break;
            case RoomWidgetChatUpdateEvent.const_95:
               _loc1_ = "bubble_shout";
               break;
            case RoomWidgetChatUpdateEvent.const_130:
               _loc1_ = "bubble_generic";
         }
         var _loc2_:XmlAsset = _assetLibrary.getAssetByName(_loc1_) as XmlAsset;
         if(_loc2_ == null || _loc2_.content == null)
         {
            return;
         }
         var _loc3_:BitmapDataAsset = _assetLibrary.getAssetByName("chat_bubble_left") as BitmapDataAsset;
         var _loc4_:BitmapData = _loc3_.content as BitmapData;
         var _loc5_:BitmapDataAsset = _assetLibrary.getAssetByName("chat_bubble_middle") as BitmapDataAsset;
         var _loc6_:BitmapData = _loc5_.content as BitmapData;
         var _loc7_:BitmapDataAsset = _assetLibrary.getAssetByName("chat_bubble_left_color") as BitmapDataAsset;
         var _loc8_:BitmapData = _loc7_.content as BitmapData;
         var _loc9_:BitmapDataAsset = _assetLibrary.getAssetByName("chat_bubble_left_gen") as BitmapDataAsset;
         var _loc10_:BitmapData = _loc9_.content as BitmapData;
         var _loc11_:BitmapDataAsset = _assetLibrary.getAssetByName("chat_bubble_right") as BitmapDataAsset;
         var _loc12_:BitmapData = _loc11_.content as BitmapData;
         var _loc13_:BitmapDataAsset = _assetLibrary.getAssetByName("chat_bubble_pointer") as BitmapDataAsset;
         var _loc14_:BitmapData = _loc13_.content as BitmapData;
         var _loc15_:Number = _loc4_.height + _loc14_.height;
         var _loc16_:int = 0;
         if(var_195 != null)
         {
            _loc16_ = Math.max(0,(0 - _loc4_.height) / 2);
            _loc15_ = Math.max(_loc15_,var_195.height);
         }
         _window = _windowManager.buildFromXML(_loc2_.content as XML,1) as IWindowContainer;
         _window.tags.push("roomchat_bubble");
         _window.x = var_88;
         _window.y = _y;
         _window.width = 0;
         _window.height = _loc15_;
         var_100 = _window as IRegionWindow;
         var_100.background = true;
         var_100.alphaTreshold = 0;
         enableTooltip();
         addEventListenerToChild(var_100);
         var _loc17_:IBitmapWrapperWindow = _window.findChildByName("left_color") as IBitmapWrapperWindow;
         var _loc18_:ITextWindow = _window.findChildByName("name") as ITextWindow;
         var _loc19_:ITextWindow = _window.findChildByName("message") as ITextWindow;
         var _loc20_:IBitmapWrapperWindow = _window.findChildByName("left") as IBitmapWrapperWindow;
         var _loc21_:IBitmapWrapperWindow = _window.findChildByName("middle") as IBitmapWrapperWindow;
         var _loc22_:IBitmapWrapperWindow = _window.findChildByName("right") as IBitmapWrapperWindow;
         var _loc23_:IBitmapWrapperWindow = _window.findChildByName("pointer") as IBitmapWrapperWindow;
         if(var_195 != null && var_637 != RoomWidgetChatUpdateEvent.const_130)
         {
            _loc25_ = 14;
            _loc26_ = Math.max(0,(_loc4_.height - 0) / 2);
            _loc27_ = _window.findChildByName("user_image") as IBitmapWrapperWindow;
            if(_loc27_ != null)
            {
               _loc27_.width = var_195.width;
               _loc27_.height = var_195.height;
               _loc27_.bitmap = new BitmapData(var_195.width,var_195.height,true,0);
               _loc27_.bitmap.copyPixels(var_195,var_195.rect,new Point(0,0));
               _loc27_.x = _loc25_;
               _loc27_.y = _loc26_;
               var_376 = Math.max(0,(0 - _loc4_.height) / 2);
               _width += var_195.width;
            }
         }
         if(_loc17_ != null)
         {
            _loc28_ = new BitmapData(_loc4_.width,_loc4_.height,true,0);
            _loc29_ = new Matrix();
            _loc30_ = 232;
            _loc31_ = 177;
            _loc32_ = 55;
            if(var_939 != 0)
            {
               _loc30_ = uint(var_939 >> 16 & 255);
               _loc31_ = uint(var_939 >> 8 & 255);
               _loc32_ = uint(var_939 >> 0 & 255);
            }
            _loc33_ = _loc30_ / 255 * 1;
            _loc34_ = _loc31_ / 255 * 1;
            _loc35_ = _loc32_ / 255 * 1;
            _loc36_ = new ColorTransform(_loc33_,_loc34_,_loc35_);
            if(var_637 == RoomWidgetChatUpdateEvent.const_130)
            {
               _loc17_.bitmap = _loc10_.clone();
            }
            else
            {
               _loc17_.bitmap = new BitmapData(_loc8_.width,_loc8_.height,true,0);
               _loc17_.bitmap.draw(_loc8_,null,_loc36_,BlendMode.DARKEN);
            }
            _loc17_.y += var_376;
         }
         if(_loc20_ != null)
         {
            _width = _loc20_.width;
            _loc20_.bitmap = _loc4_;
            _loc20_.disposesBitmap = false;
            _loc20_.y += var_376;
         }
         if(_loc18_ != null)
         {
            if(var_637 == RoomWidgetChatUpdateEvent.const_130)
            {
               _width += _loc18_.textWidth + const_331;
            }
            else
            {
               _loc18_.text = var_936 + ":";
               _loc18_.y += var_376;
               _loc18_.width = _loc18_.textWidth + const_331;
               _width += _loc18_.textWidth + const_331;
            }
         }
         if(_loc19_ != null)
         {
            if(var_637 == RoomWidgetChatUpdateEvent.const_130)
            {
               _loc19_.text = _localizations.registerParameter("widgets.chatbubble.respect","username",var_936);
            }
            else
            {
               _loc19_.text = _message;
            }
            if(var_637 == RoomWidgetChatUpdateEvent.const_98)
            {
               _loc19_.htmlText = "<i>" + _message + "</i>";
            }
            _loc19_.x = _width;
            _loc19_.y += var_376;
            _loc19_.width = _loc19_.textWidth + const_471;
            _width += _loc19_.textWidth + const_471;
         }
         if(_loc21_ != null)
         {
            _loc21_.width = _loc18_.textWidth + const_331 + _loc19_.textWidth + const_471;
            _loc37_ = new Matrix();
            _loc37_.scale(_loc21_.width / _loc6_.width,1);
            _loc38_ = new BitmapData(_loc21_.width,_loc21_.height,true);
            _loc38_.draw(_loc6_,_loc37_);
            _loc21_.bitmap = new BitmapData(_loc21_.width,_loc6_.height,false);
            _loc21_.bitmap.copyPixels(_loc38_,_loc38_.rect,new Point(0,0));
            _loc21_.y += var_376;
         }
         if(_loc22_ != null)
         {
            _loc22_.bitmap = _loc12_;
            _loc22_.disposesBitmap = false;
            _loc22_.x = _width;
            _loc22_.y += var_376;
            _width += _loc22_.width;
         }
         if(_loc23_ != null)
         {
            _loc23_.bitmap = _loc14_;
            _loc23_.disposesBitmap = false;
            _loc23_.x = _width / 2;
            _loc23_.y += var_376;
         }
         _window.width = _width;
         _window.height = _loc15_;
         _window.y = 0 - var_376;
         var _loc24_:IWindow = _window.getChildByName("bubblecont");
         if(_loc24_ != null)
         {
            _loc24_.width = _width;
            _loc24_.height = _loc15_;
         }
      }
      
      private function onBubbleMouseDown(param1:WindowMouseEvent) : void
      {
         _widget.onItemMouseDown(var_937,var_938,_roomId,_roomCategory,param1);
      }
      
      public function set aboveLevels(param1:int) : void
      {
         var_1935 = param1;
      }
      
      private function onBubbleMouseOver(param1:WindowMouseEvent) : void
      {
         _widget.onItemMouseOver(var_937,var_938,_roomId,_roomCategory,param1);
      }
      
      public function get aboveLevels() : int
      {
         return var_1935;
      }
      
      private function onBubbleMouseUp(param1:WindowMouseEvent) : void
      {
         _widget.mouseUp();
      }
      
      public function setPointerOffset(param1:Number) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = _window.findChildByName("pointer") as IBitmapWrapperWindow;
         var _loc3_:IBitmapWrapperWindow = _window.findChildByName("middle") as IBitmapWrapperWindow;
         if(_loc3_ == null || _loc2_ == null)
         {
            return;
         }
         _loc2_.visible = true;
         param1 += 0;
         param1 = Math.min(param1,_loc3_.rectangle.right - _loc2_.width);
         param1 = Math.max(param1,_loc3_.rectangle.left);
         _loc2_.x = param1;
      }
      
      public function set screenLevel(param1:int) : void
      {
         var_1934 = param1;
      }
      
      public function set x(param1:Number) : void
      {
         var_88 = param1;
         if(_window != null)
         {
            _window.x = param1;
         }
      }
      
      public function get screenLevel() : int
      {
         return var_1934;
      }
   }
}
