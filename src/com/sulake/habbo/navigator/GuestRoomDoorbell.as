package com.sulake.habbo.navigator
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.ICoreWindowManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import flash.geom.Point;
   
   public class GuestRoomDoorbell
   {
       
      
      private var var_794:GuestRoomData;
      
      private var var_2023:Boolean;
      
      private var _window:IFrameWindow;
      
      private var _navigator:HabboNavigator;
      
      public function GuestRoomDoorbell(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      private function ringDoorbell(param1:WindowMouseEvent) : void
      {
         _navigator.goToRoom(var_794.flatId,true);
         hide();
      }
      
      public function hide() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.visible = false;
      }
      
      private function setText(param1:String, param2:String) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc3_:IWindow = _window.findChildByName(param1);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.caption = param2;
      }
      
      private function createWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         var _loc1_:XmlAsset = _navigator.assets.getAssetByName("doorbell_xml") as XmlAsset;
         _window = (_navigator.windowManager as ICoreWindowManager).buildFromXML(_loc1_.content as XML,2) as IFrameWindow;
         if(_window == null)
         {
            return;
         }
         var _loc2_:IButtonWindow = _window.findChildByName("ring") as IButtonWindow;
         if(_loc2_ != null)
         {
            _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,ringDoorbell);
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
      
      private function showButton(param1:String, param2:Boolean) : void
      {
         var _loc3_:IButtonWindow = _window.findChildByName(param1) as IButtonWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.visible = param2;
      }
      
      public function showWaiting() : void
      {
         show(var_794,null,true);
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
      
      public function showNoAnswer() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.visible = true;
         _window.activate();
         setText("info","${navigator.doorbell.no.answer}");
         showButton("ring",false);
      }
      
      public function show(param1:GuestRoomData, param2:Point = null, param3:Boolean = false) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_794 = param1;
         var_2023 = param3;
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
         var _loc4_:ITextWindow = _window.findChildByName("room_name") as ITextWindow;
         if(_loc4_ != null)
         {
            _loc4_.text = param1.roomName;
         }
         if(var_2023)
         {
            setText("info","${navigator.doorbell.waiting}");
            setText("cancel","${navigator.doorbell.button.cancel.entering}");
            showButton("ring",false);
         }
         else
         {
            setText("info","${navigator.doorbell.info}");
            setText("cancel","${generic.cancel}");
            showButton("ring",true);
         }
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
