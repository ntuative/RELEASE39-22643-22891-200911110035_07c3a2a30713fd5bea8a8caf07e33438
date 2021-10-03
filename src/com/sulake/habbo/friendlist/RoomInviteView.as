package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.SendRoomInviteMessageComposer;
   import com.sulake.habbo.friendlist.domain.Friend;
   import flash.events.Event;
   import flash.ui.Keyboard;
   
   public class RoomInviteView extends AlertView
   {
       
      
      private var _selected:Array;
      
      private var var_657:ITextFieldWindow;
      
      public function RoomInviteView(param1:HabboFriendList)
      {
         super(param1,"room_invite_confirm");
         _selected = param1.categories.getSelectedFriends();
      }
      
      private function onMessageInput(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc2_:IWindow = IWindow(param1.target);
         Logger.log("Test key event " + param1 + ", " + param1.type + " " + _loc2_.name);
         if(!(param1 is WindowKeyboardEvent))
         {
            return;
         }
         var _loc3_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         if(_loc3_.charCode == Keyboard.ENTER)
         {
            sendMsg();
         }
         else
         {
            _loc4_ = 120;
            _loc5_ = "null";
            if(_loc5_.length > _loc4_)
            {
               var_657.text = _loc5_.substring(0,_loc4_);
            }
         }
      }
      
      private function onInvite(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Invite Ok clicked");
         sendMsg();
         dispose();
      }
      
      private function sendMsg() : void
      {
         var _loc3_:* = null;
         var _loc1_:String = "null";
         Logger.log("Send msg: " + _loc1_);
         if(_loc1_ == "")
         {
            new SimpleAlertView(friendList,"${friendlist.invite.emptyalert.title}","${friendlist.invite.emptyalert.text}").show();
            return;
         }
         var _loc2_:SendRoomInviteMessageComposer = new SendRoomInviteMessageComposer(_loc1_);
         for each(_loc3_ in _selected)
         {
            _loc2_.addInvitedFriend(_loc3_.id);
         }
         friendList.send(_loc2_);
         dispose();
      }
      
      override function setupContent(param1:IWindowContainer) : void
      {
         friendList.registerParameter("friendlist.invite.summary","count","undefined");
         var_657 = ITextFieldWindow(param1.findChildByName("message_input"));
         var_657.addEventListener(WindowKeyboardEvent.const_140,onMessageInput);
         param1.findChildByName("cancel").procedure = onClose;
         param1.findChildByName("ok").procedure = onInvite;
      }
      
      override public function dispose() : void
      {
         _selected = null;
         var_657 = null;
         super.dispose();
      }
   }
}
