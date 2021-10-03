package com.sulake.habbo.navigator
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.ICoreWindowManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.IPasswordFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import flash.geom.Point;
   
   public class GuestRoomPasswordInput
   {
       
      
      private var var_794:GuestRoomData;
      
      private var _window:IFrameWindow;
      
      private var _navigator:HabboNavigator;
      
      public function GuestRoomPasswordInput(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      private function hide(param1:WindowMouseEvent = null) : void
      {
         if(_window == null)
         {
            return;
         }
         _window.visible = false;
      }
      
      private function close(param1:WindowMouseEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         _window.dispose();
         _window = null;
      }
      
      public function showRetry() : void
      {
         show(var_794);
         setInfoText("${navigator.password.retryinfo}");
      }
      
      private function createWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         var _loc1_:XmlAsset = _navigator.assets.getAssetByName("password_input_xml") as XmlAsset;
         _window = (_navigator.windowManager as ICoreWindowManager).buildFromXML(_loc1_.content as XML,2) as IFrameWindow;
         if(_window == null)
         {
            return;
         }
         var _loc2_:IButtonWindow = _window.findChildByName("try") as IButtonWindow;
         if(_loc2_ != null)
         {
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onTry);
         }
         var _loc3_:IButtonWindow = _window.findChildByName("cancel") as IButtonWindow;
         if(_loc3_ != null)
         {
            _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,close);
         }
         var _loc4_:IWindow = _window.findChildByTag("close");
         if(_loc4_ != null)
         {
            _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,close);
         }
      }
      
      public function show(param1:GuestRoomData, param2:Point = null) : void
      {
         var_794 = param1;
         if(var_794 == null)
         {
            return;
         }
         createWindow();
         if(_window == null)
         {
            return;
         }
         if(param2 != null)
         {
            param2.offset(0,0);
            _window.setGlobalPosition(param2);
         }
         _window.visible = true;
         _window.activate();
         var _loc3_:ITextWindow = _window.findChildByName("room_name") as ITextWindow;
         if(_loc3_ != null && param1 != null)
         {
            _loc3_.text = param1.roomName;
         }
         var _loc4_:IPasswordFieldWindow = _window.findChildByName("password_input") as IPasswordFieldWindow;
         if(_loc4_ != null)
         {
            _loc4_.text = "";
         }
         setInfoText("${navigator.password.info}");
      }
      
      private function onTry(param1:WindowMouseEvent) : void
      {
         var _loc2_:IPasswordFieldWindow = _window.findChildByName("password_input") as IPasswordFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:String = _loc2_.text;
         _navigator.goToRoom(var_794.flatId,true,_loc3_);
         hide();
      }
      
      private function setInfoText(param1:String) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:ITextWindow = _window.findChildByName("info") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.caption = param1;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
         }
         _window = null;
         _navigator = null;
         var_794 = null;
      }
   }
}
