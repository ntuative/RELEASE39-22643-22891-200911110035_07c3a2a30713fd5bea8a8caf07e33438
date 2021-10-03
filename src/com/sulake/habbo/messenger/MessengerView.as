package com.sulake.habbo.messenger
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.SendMsgMessageComposer;
   import com.sulake.habbo.messenger.domain.Conversation;
   import com.sulake.habbo.messenger.domain.Message;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   
   public class MessengerView
   {
       
      
      private var var_1148:ConversationView;
      
      private var var_35:IFrameWindow;
      
      private var var_776:ConversationsTabView;
      
      private var var_418:Timer;
      
      private var var_131:HabboMessenger;
      
      private var var_657:ITextFieldWindow;
      
      public function MessengerView(param1:HabboMessenger)
      {
         super();
         var_131 = param1;
         var_418 = new Timer(300,1);
         var_418.addEventListener(TimerEvent.TIMER,onResizeTimer);
      }
      
      public function addMsgToView(param1:Conversation, param2:Message) : void
      {
         if(var_35 == null)
         {
            return;
         }
         if(!param1.selected)
         {
            return;
         }
         var_1148.addMessage(param2);
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         Logger.log("XXX RESIZE XXX");
         this.var_1148.afterResize();
         this.var_776.refresh();
      }
      
      private function onMessageInput(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc2_:IWindow = IWindow(param1.target);
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
      
      public function getTabCount() : int
      {
         return this.var_776 == null ? 7 : int(this.var_776.getTabCount());
      }
      
      public function openMessenger() : void
      {
         if(var_131.conversations.openConversations.length < 1)
         {
            return;
         }
         if(var_35 == null)
         {
            prepareContent();
            refresh(true);
            var_131.toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.const_74,HabboToolbarIconEnum.MESSENGER,var_35));
         }
         else
         {
            refresh(true);
            var_35.visible = true;
            var_35.activate();
         }
      }
      
      private function sendMsg() : void
      {
         var _loc1_:String = "null";
         Logger.log("Send msg: " + _loc1_);
         if(_loc1_ == "")
         {
            Logger.log("No text...");
            return;
         }
         var _loc2_:Conversation = var_131.conversations.findSelectedConversation();
         if(_loc2_ == null)
         {
            Logger.log("No conversation...");
            return;
         }
         var_131.send(new SendMsgMessageComposer(_loc2_.id,_loc1_));
         var_657.text = "";
         var_131.conversations.addMessageAndUpdateView(new Message(Message.const_568,_loc2_.id,_loc1_,Util.getFormattedNow()));
      }
      
      private function onWindow(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_46 || param2 != var_35)
         {
            return;
         }
         if(!this.var_418.running)
         {
            this.var_418.reset();
            this.var_418.start();
         }
      }
      
      private function prepareContent() : void
      {
         var_35 = IFrameWindow(var_131.getXmlWindow("main_window"));
         var _loc1_:IWindow = var_35.findChildByTag("close");
         _loc1_.procedure = onWindowClose;
         var_35.procedure = onWindow;
         var_35.title.color = 4294623744;
         var_35.title.textColor = 4287851525;
         var_776 = new ConversationsTabView(var_131,var_35);
         var_776.refresh();
         var_657 = ITextFieldWindow(var_35.findChildByName("message_input"));
         var_657.addEventListener(WindowKeyboardEvent.const_140,onMessageInput);
         var_1148 = new ConversationView(var_131,var_35);
         var_35.scaler.setParamFlag(HabboWindowParam.const_533,false);
         var_35.scaler.setParamFlag(HabboWindowParam.const_758,true);
      }
      
      public function isMessengerOpen() : Boolean
      {
         return var_35 != null && false;
      }
      
      public function refresh(param1:Boolean) : void
      {
         if(var_35 == null)
         {
            return;
         }
         var _loc2_:Conversation = var_131.conversations.findSelectedConversation();
         var_35.caption = _loc2_ == null ? "" : _loc2_.name;
         var_776.refresh();
         var_1148.refresh();
         if(var_131.conversations.openConversations.length < 1)
         {
            var_35.visible = false;
            var_131.setHabboToolbarIcon(false,false);
         }
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Close window");
         var_35.visible = false;
      }
      
      public function close() : void
      {
         if(var_35 != null)
         {
            var_35.visible = false;
         }
      }
   }
}
