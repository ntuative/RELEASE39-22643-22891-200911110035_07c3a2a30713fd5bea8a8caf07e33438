package com.sulake.habbo.widget.chatinput
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.widget.messages.RoomWidgetChatMessage;
   import com.sulake.habbo.widget.messages.RoomWidgetChatTypingMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   
   public class RoomChatInputView
   {
      
      private static const const_1309:int = 5;
      
      private static const const_471:int = 16;
      
      private static const const_1033:int = 20;
      
      private static const const_331:int = 10;
      
      private static const const_1034:int = 40;
       
      
      private var _assetLibrary:IAssetLibrary;
      
      private var var_922:String;
      
      private var _window:IWindowContainer;
      
      private var var_1881:String;
      
      private var var_439:Boolean = false;
      
      private var var_383:Number = 600;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_1880:String;
      
      private var var_2116:int = 0;
      
      private var var_1145:Boolean = false;
      
      private var var_136:String = "";
      
      private var var_626:Timer;
      
      private var var_772:Timer;
      
      private var _widget:RoomChatInputWidget;
      
      private var _localization:IHabboLocalizationManager;
      
      private var var_1882:Number = 0;
      
      public function RoomChatInputView(param1:RoomChatInputWidget, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager)
      {
         super();
         _widget = param1;
         _windowManager = param2;
         _assetLibrary = param3;
         _localization = param4;
         var_922 = _localization.getKey("widgets.chatinput.mode.whisper",":tell");
         var_1880 = _localization.getKey("widgets.chatinput.mode.shout",":shout");
         var_1881 = _localization.getKey("widgets.chatinput.mode.speak",":speak");
         var_626 = new Timer(1000,1);
         var_626.addEventListener(TimerEvent.TIMER_COMPLETE,onTypingTimerComplete);
         var_772 = new Timer(5000,1);
         var_772.addEventListener(TimerEvent.TIMER_COMPLETE,onIdleTimerComplete);
         createWindow();
         refreshView();
      }
      
      public function hideView() : void
      {
         if(_window != null)
         {
            _window.dispose();
         }
         _window = null;
      }
      
      private function onInputChanged(param1:WindowEvent) : void
      {
         var _loc2_:ITextFieldWindow = param1.window as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var_772.reset();
         var _loc3_:* = _loc2_.text.length == 0;
         if(_loc3_)
         {
            var_439 = false;
            var_626.start();
         }
         else
         {
            if(_loc2_.text.length > NaN)
            {
               _loc2_.text = "";
            }
            var_136 = _loc2_.text;
            if(!var_439)
            {
               var_439 = true;
               var_626.reset();
               var_626.start();
            }
            var_772.start();
         }
      }
      
      private function onIdleTimerComplete(param1:TimerEvent) : void
      {
         var_439 = false;
         sendTypingMessage();
      }
      
      private function createWindow() : void
      {
         if(_window != null)
         {
            refreshView();
            return;
         }
         var _loc2_:XmlAsset = _assetLibrary.getAssetByName("chatinput_window") as XmlAsset;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.content == null)
         {
            return;
         }
         _window = _windowManager.createWindow("chatinput_widget_window","",HabboWindowType.const_53,HabboWindowStyle.const_38,0 | 0,new Rectangle(300,400,400,30),null) as IWindowContainer;
         _window.buildFromXML(_loc2_.content as XML);
         _window.tags.push("room_widget_chatinput");
         var _loc3_:IBitmapWrapperWindow = _window.findChildByName("left") as IBitmapWrapperWindow;
         var _loc4_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         var _loc5_:IBitmapWrapperWindow = _window.findChildByName("middle") as IBitmapWrapperWindow;
         var _loc6_:IBitmapWrapperWindow = _window.findChildByName("right") as IBitmapWrapperWindow;
         addEventListenerToChild(_loc3_);
         addEventListenerToChild(_loc4_);
         addEventListenerToChild(_loc5_);
         addEventListenerToChild(_loc6_);
         _loc4_.addEventListener(WindowKeyboardEvent.const_140,windowKeyEventProcessor);
         _loc4_.addEventListener(WindowEvent.const_46,onInputFieldResized);
         _loc4_.addEventListener(WindowEvent.const_246,onInputChanged);
         _window.addEventListener(WindowEvent.const_434,onWindowMoved);
         var_1145 = true;
         var_136 = "";
      }
      
      private function onTypingTimerComplete(param1:TimerEvent) : void
      {
         sendTypingMessage();
      }
      
      private function windowMouseEventProcessor(param1:Event = null, param2:IWindow = null) : void
      {
         setInputFieldFocus();
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
         }
         _window = null;
         _widget = null;
         _windowManager = null;
         _assetLibrary = null;
         var_626 = null;
         var_772 = null;
      }
      
      private function setInputFieldFocus() : void
      {
         var _loc1_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return;
         }
         if(var_1145)
         {
            _loc1_.text = "";
            _loc1_.textColor = 0;
            var_1145 = false;
            var_136 = "";
         }
         _loc1_.focus();
      }
      
      private function refreshView() : void
      {
         var _loc15_:* = null;
         var _loc16_:* = null;
         if(_window == null)
         {
            return;
         }
         var _loc1_:BitmapDataAsset = _assetLibrary.getAssetByName("chatinput_bubble_left") as BitmapDataAsset;
         var _loc2_:BitmapData = (_loc1_.content as BitmapData).clone();
         var _loc3_:BitmapDataAsset = _assetLibrary.getAssetByName("chatinput_bubble_middle") as BitmapDataAsset;
         var _loc4_:BitmapData = (_loc3_.content as BitmapData).clone();
         var _loc5_:BitmapDataAsset = _assetLibrary.getAssetByName("chatinput_bubble_right") as BitmapDataAsset;
         var _loc6_:BitmapData = (_loc5_.content as BitmapData).clone();
         var _loc7_:IBitmapWrapperWindow = _window.findChildByName("left") as IBitmapWrapperWindow;
         var _loc8_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         var _loc9_:IBitmapWrapperWindow = _window.findChildByName("middle") as IBitmapWrapperWindow;
         var _loc10_:IBitmapWrapperWindow = _window.findChildByName("right") as IBitmapWrapperWindow;
         var _loc11_:Number = _loc2_.height;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var_1882 = _loc2_.width + const_471 + _loc6_.width + const_1033;
         if(_loc7_ != null)
         {
            _loc12_ = Number(_loc7_.width);
            _loc7_.bitmap = _loc2_;
         }
         if(_loc8_ != null)
         {
            _loc13_ = Number(Math.max(const_1034,_loc8_.width) + const_471);
            _loc8_.x = _loc12_;
            _loc8_.background = false;
            _loc8_.invalidate();
         }
         if(_loc9_ != null)
         {
            _loc9_.width = _loc13_;
            _loc12_ += _loc13_;
            _loc15_ = new Matrix();
            _loc15_.scale(_loc9_.width / _loc4_.width,1);
            _loc16_ = new BitmapData(_loc9_.width,_loc9_.height,true);
            _loc16_.draw(_loc4_,_loc15_);
            _loc9_.bitmap = new BitmapData(_loc9_.width,_loc4_.height,false);
            _loc9_.bitmap.copyPixels(_loc16_,_loc16_.rect,new Point(0,0));
         }
         if(_loc10_ != null)
         {
            _loc10_.bitmap = _loc6_;
            _loc10_.x = _loc12_;
            _loc12_ += _loc10_.width;
         }
         _window.width = _loc12_;
         _window.height = _loc11_;
         var _loc14_:IWindow = _window.getChildByName("bubblecont");
         if(_loc14_ != null)
         {
            _loc14_.width = _loc12_;
            _loc14_.height = _loc11_;
         }
      }
      
      private function onInputFieldResized(param1:WindowEvent) : void
      {
         checkInputFieldLimits();
         refreshView();
      }
      
      private function setInputFieldUnFocus() : void
      {
         var _loc1_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.unfocus();
      }
      
      private function checkInputFieldLimits() : void
      {
         var _loc1_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return;
         }
         if(_loc1_.textWidth >= var_383)
         {
            if(_loc1_.autoSize != TextFieldAutoSize.NONE)
            {
               _loc1_.autoSize = TextFieldAutoSize.NONE;
            }
         }
         else if(_loc1_.autoSize != TextFieldAutoSize.LEFT)
         {
            _loc1_.autoSize = TextFieldAutoSize.LEFT;
         }
      }
      
      public function hideFloodBlocking() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.enable();
         _loc1_.selectable = true;
         _loc1_.text = "";
         var_136 = "";
         setInputFieldFocus();
         checkInputFieldLimits();
      }
      
      private function anotherFieldHasFocus() : Boolean
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc1_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc1_ != null)
         {
            if(_loc1_.focused)
            {
               return false;
            }
         }
         var _loc2_:DisplayObject = _window.context.getDesktopWindow().getDisplayObject();
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.stage;
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.focus;
               if(_loc4_ == null)
               {
                  return false;
               }
               if(_loc4_ is TextField)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function checkSpecialKeywordForInput() : void
      {
         var _loc1_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return;
         }
         if(_loc1_.text == "")
         {
            return;
         }
         var _loc2_:String = _loc1_.text;
         var _loc3_:String = "null";
         if(_loc2_ == var_922)
         {
            if(_loc3_.length > 0)
            {
               _loc1_.text += " undefined";
               _loc1_.setSelection(_loc1_.text.length,_loc1_.text.length);
               var_136 = _loc1_.text;
            }
         }
      }
      
      private function sendChatFromInputField(param1:int) : void
      {
         var _loc2_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.text == "")
         {
            return;
         }
         var _loc3_:String = _loc2_.text;
         if(false && _loc3_ == ":crashme")
         {
            _widget.triggerManualCrash();
            _loc2_.text = "";
            var_136 = "";
            return;
         }
         var _loc4_:Array = _loc3_.split(" ");
         var _loc5_:String = "";
         var _loc6_:* = "";
         switch(_loc4_[0])
         {
            case var_922:
               param1 = 0;
               _loc5_ = _loc4_[1];
               _loc6_ = var_922 + " " + _loc5_ + " ";
               _loc4_.shift();
               _loc4_.shift();
               break;
            case var_1880:
               param1 = 0;
               _loc4_.shift();
               break;
            case var_1881:
               param1 = 0;
               _loc4_.shift();
         }
         _loc3_ = _loc4_.join(" ");
         if(_widget != null)
         {
            _widget.sendChat(_loc3_,param1,_loc5_);
            var_439 = false;
            sendTypingMessage();
         }
         _loc2_.text = _loc6_;
         var_136 = _loc6_;
         refreshView();
      }
      
      private function windowKeyEventProcessor(param1:Event = null, param2:IWindow = null) : void
      {
         var _loc4_:* = 0;
         var _loc5_:Boolean = false;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         if(_window == null || _widget == null || false)
         {
            return;
         }
         if(anotherFieldHasFocus())
         {
            return;
         }
         var _loc3_:int = var_2116;
         setInputFieldFocus();
         if(param1 is WindowKeyboardEvent)
         {
            _loc6_ = param1 as WindowKeyboardEvent;
            _loc4_ = uint(_loc6_.charCode);
            _loc5_ = _loc6_.shiftKey;
         }
         if(param1 is KeyboardEvent)
         {
            _loc7_ = param1 as KeyboardEvent;
            _loc4_ = uint(_loc7_.charCode);
            _loc5_ = _loc7_.shiftKey;
         }
         if(_loc7_ == null && _loc6_ == null)
         {
            return;
         }
         if(_loc5_)
         {
            _loc3_ = 0;
         }
         if(_loc4_ == Keyboard.SPACE)
         {
            checkSpecialKeywordForInput();
         }
         if(_loc4_ == Keyboard.ENTER)
         {
            sendChatFromInputField(_loc3_);
         }
         if(_loc4_ == Keyboard.BACKSPACE)
         {
            _loc8_ = _window.findChildByName("chat_input") as ITextFieldWindow;
            if(_loc8_ != null)
            {
               _loc9_ = _loc8_.text;
               _loc10_ = _loc9_.split(" ");
               if(_loc10_[0] == var_922 && _loc10_.length == 3 && _loc10_[2] == "")
               {
                  _loc8_.text = "";
                  var_136 = "";
               }
            }
         }
         checkInputFieldLimits();
      }
      
      public function setMaxWidth(param1:Number) : void
      {
         var_383 = param1 - var_1882;
         var _loc2_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Number = _loc2_.width;
         if(int(_loc2_.textWidth) > _loc2_.width)
         {
            _loc3_ = Math.min(int(_loc2_.textWidth),var_383);
         }
         else
         {
            _loc3_ = Math.min(_loc3_,var_383);
         }
         if(_loc3_ != _loc2_.width)
         {
            _loc2_.width = _loc3_;
         }
         checkInputFieldLimits();
         refreshView();
      }
      
      private function onWindowMoved(param1:WindowEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         setMaxWidth(_window.context.getDesktopWindow().width - 0);
      }
      
      private function addEventListenerToChild(param1:IWindow) : void
      {
         if(param1 != null)
         {
            param1.setParamFlag(HabboWindowParam.const_34,true);
            param1.addEventListener(WindowMouseEvent.const_67,windowMouseEventProcessor);
         }
      }
      
      public function showFloodBlocking(param1:int) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.disable();
         _loc2_.selectable = false;
         _localization.registerParameter("chat.input.alert.flood","time",param1.toString());
         var _loc3_:ILocalization = _localization.getLocalization("chat.input.alert.flood");
         var _loc4_:String = "";
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.value;
         }
         _loc2_.text = _loc4_;
         setInputFieldUnFocus();
         refreshView();
      }
      
      private function sendTypingMessage() : void
      {
         if(_widget == null)
         {
            return;
         }
         if(false)
         {
            return;
         }
         var _loc1_:RoomWidgetChatTypingMessage = new RoomWidgetChatTypingMessage(var_439);
         _widget.messageListener.processWidgetMessage(_loc1_);
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function displaySpecialChatMessage(param1:String, param2:String = "") : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc3_:ITextFieldWindow = _window.findChildByName("chat_input") as ITextFieldWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.enable();
         _loc3_.selectable = true;
         _loc3_.text = "";
         setInputFieldFocus();
         _loc3_.text += param1 + " ";
         if(param2.length > 0)
         {
            _loc3_.text += param2 + " ";
         }
         _loc3_.setSelection(_loc3_.text.length,_loc3_.text.length);
         var_136 = _loc3_.text;
         checkInputFieldLimits();
      }
   }
}
