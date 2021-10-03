package com.sulake.habbo.moderation
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.ChatlineData;
   import com.sulake.habbo.communication.messages.incoming.moderation.RoomChatlogData;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class ChatlogCtrl implements IDisposable, TrackedWindow
   {
       
      
      private var var_1373:IMessageComposer;
      
      private var var_418:Timer;
      
      private var _disposed:Boolean;
      
      private var var_53:ModerationManager;
      
      private var _type:int;
      
      private var var_719:IWindowContainer;
      
      private var var_718:IWindowContainer;
      
      private var var_56:IFrameWindow;
      
      private var var_1075:Dictionary;
      
      private var var_107:Array;
      
      private var _id:int;
      
      private var _list:IItemListWindow;
      
      public function ChatlogCtrl(param1:IMessageComposer, param2:ModerationManager, param3:int, param4:int)
      {
         super();
         var_53 = param2;
         _type = param3;
         _id = param4;
         var_1373 = param1;
      }
      
      public function show() : void
      {
         var_719 = IWindowContainer(var_53.getXmlWindow("chatlog_roomheader"));
         var_718 = IWindowContainer(var_53.getXmlWindow("chatlog_chatline"));
         var_418 = new Timer(300,1);
         var_418.addEventListener(TimerEvent.TIMER,onResizeTimer);
         var_56 = IFrameWindow(var_53.getXmlWindow("chatlog_frame"));
         _list = IItemListWindow(var_56.findChildByName("chatline_list"));
         var_56.procedure = onWindow;
         var _loc1_:IWindow = var_56.findChildByTag("close");
         _loc1_.procedure = onClose;
         var_53.connection.send(var_1373);
         var_53.messageHandler.addChatlogListener(this);
      }
      
      public function onChatlog(param1:String, param2:int, param3:int, param4:Array, param5:Dictionary) : void
      {
         if(param2 != _type || param3 != _id || _disposed)
         {
            return;
         }
         var_53.messageHandler.removeChatlogListener(this);
         var_56.caption = param1;
         var_107 = param4;
         var_1075 = param5;
         populate();
         onResizeTimer(null);
         var_56.visible = true;
      }
      
      public function getId() : String
      {
         return "" + _id;
      }
      
      private function populateRoomChat(param1:RoomChatlogData) : void
      {
         var _loc5_:* = null;
         var _loc2_:IWindowContainer = IWindowContainer(var_719.clone());
         var _loc3_:IWindow = _loc2_.findChildByName("room_name_txt");
         _loc3_.caption = param1.roomName;
         new OpenRoomTool(var_56,var_53,_loc3_,param1.isPublic,param1.roomId);
         _list.addListItem(_loc2_);
         var _loc4_:* = true;
         for each(_loc5_ in param1.chatlog)
         {
            populateChatline(_list,_loc5_,_loc4_);
            _loc4_ = !_loc4_;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         var_53 = null;
         if(var_56 != null)
         {
            var_56.destroy();
            var_56 = null;
         }
         if(_list != null)
         {
            _list.dispose();
            _list = null;
         }
         if(var_719 != null)
         {
            var_719.dispose();
            var_719 = null;
         }
         if(var_718 != null)
         {
            var_718.dispose();
            var_718 = null;
         }
         var_107 = null;
         var_1075 = null;
         if(var_418 != null)
         {
            var_418.stop();
            var_418 = null;
         }
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         Logger.log("XXX RESIZE XXX");
         refreshListDims();
         var _loc2_:Boolean = refreshScrollBarVisibility();
         if(_loc2_)
         {
            refreshListDims();
         }
      }
      
      private function refreshScrollBarVisibility() : Boolean
      {
         var _loc1_:IWindowContainer = IWindowContainer(_list.parent);
         var _loc2_:IWindow = _loc1_.getChildByName("scroller") as IWindow;
         var _loc3_:* = _list.scrollableRegion.height > _list.height;
         if(_loc2_.visible)
         {
            if(_loc3_)
            {
               return false;
            }
            _loc2_.visible = false;
            _list.width = NaN;
            return true;
         }
         if(_loc3_)
         {
            _loc2_.visible = true;
            _list.width = -22;
            return true;
         }
         return false;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         dispose();
      }
      
      private function populate() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in var_107)
         {
            populateRoomChat(_loc1_);
         }
      }
      
      private function onWindow(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_46 || param2 != var_56)
         {
            return;
         }
         if(!this.var_418.running)
         {
            this.var_418.reset();
            this.var_418.start();
         }
      }
      
      private function populateChatline(param1:IItemListWindow, param2:ChatlineData, param3:Boolean) : void
      {
         var _loc4_:IWindowContainer = IWindowContainer(var_718.clone());
         _loc4_.color = var_1075[param2.chatterId] != null ? (!!param3 ? 4293570819 : uint(4294955520)) : (!!param3 ? 4288861930 : uint(4294967295));
         var _loc5_:ITextWindow = ITextWindow(_loc4_.findChildByName("time_txt"));
         _loc5_.text = RoomVisitsCtrl.getFormattedTime(param2.hour,param2.minute);
         var _loc6_:ITextWindow = ITextWindow(_loc4_.findChildByName("chatter_txt"));
         _loc6_.color = _loc4_.color;
         if(param2.chatterId > 0)
         {
            _loc6_.text = param2.chatterName;
            new OpenUserInfo(var_56,var_53,_loc6_,param2.chatterId);
         }
         else
         {
            _loc6_.text = "Bot / pet";
            _loc6_.underline = false;
         }
         var _loc7_:ITextWindow = ITextWindow(_loc4_.findChildByName("msg_txt"));
         _loc7_.text = param2.msg;
         _loc7_.height = _loc7_.textHeight + 5;
         _loc4_.height = _loc7_.height;
         param1.addListItem(_loc4_);
      }
      
      private function refreshListDims() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         _list.autoArrangeItems = false;
         var _loc1_:int = 0;
         while(_loc1_ < _list.numListItems)
         {
            _loc2_ = IWindowContainer(_list.getListItemAt(_loc1_));
            if(_loc2_.name == "chatline")
            {
               _loc3_ = ITextWindow(_loc2_.findChildByName("msg_txt"));
               _loc3_.width = _loc2_.width - _loc3_.x;
               _loc3_.height = _loc3_.textHeight + 5;
               _loc3_.invalidate();
               _loc2_.height = _loc3_.height;
               Logger.log("REFRESHED DIMS: " + _loc2_.rectangle + ", " + _loc3_.rectangle);
            }
            _loc1_++;
         }
         _list.autoArrangeItems = true;
      }
      
      public function getFrame() : IFrameWindow
      {
         return var_56;
      }
      
      public function getType() : int
      {
         return _type;
      }
   }
}
