package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitData;
   import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitsData;
   import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomVisitsMessageComposer;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RoomVisitsCtrl implements IDisposable, TrackedWindow
   {
       
      
      private var var_107:Array;
      
      private var _disposed:Boolean;
      
      private var _list:IItemListWindow;
      
      private var var_53:ModerationManager;
      
      private var var_1924:IWindowContainer;
      
      private var _userId:int;
      
      private var var_56:IFrameWindow;
      
      private var var_418:Timer;
      
      public function RoomVisitsCtrl(param1:ModerationManager, param2:int)
      {
         super();
         var_53 = param1;
         _userId = param2;
      }
      
      public static function getFormattedTime(param1:int, param2:int) : String
      {
         return padToTwoDigits(param1) + ":" + padToTwoDigits(param2);
      }
      
      public static function padToTwoDigits(param1:int) : String
      {
         return param1 < 10 ? "0" + param1 : "" + param1;
      }
      
      public function onRoomVisits(param1:RoomVisitsData) : void
      {
         if(param1.userId != _userId)
         {
            return;
         }
         if(_disposed)
         {
            return;
         }
         this.var_107 = param1.rooms;
         var_56.caption = "Room visits: " + param1.userName;
         populate();
         onResizeTimer(null);
         var_56.visible = true;
         var_53.messageHandler.removeRoomVisitsListener(this);
      }
      
      public function getId() : String
      {
         return "" + _userId;
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         var _loc2_:IWindowContainer = IWindowContainer(_list.parent);
         var _loc3_:IWindow = _loc2_.getChildByName("scroller") as IWindow;
         var _loc4_:* = _list.scrollableRegion.height > _list.height;
         if(_loc3_.visible)
         {
            if(!_loc4_)
            {
               _loc3_.visible = false;
               _list.width = NaN;
            }
         }
         else if(_loc4_)
         {
            _loc3_.visible = true;
            _list.width = -17;
         }
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         dispose();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_56 != null)
         {
            var_56.destroy();
            var_56 = null;
         }
         var_53 = null;
      }
      
      private function populate() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = true;
         for each(_loc2_ in var_107)
         {
            populateRoomRow(_loc2_,_loc1_);
            _loc1_ = !_loc1_;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
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
      
      private function populateRoomRow(param1:RoomVisitData, param2:Boolean) : void
      {
         var _loc3_:IWindowContainer = IWindowContainer(var_1924.clone());
         var _loc4_:uint = !!param2 ? 4288861930 : uint(4294967295);
         _loc3_.color = _loc4_;
         var _loc5_:IWindow = _loc3_.findChildByName("room_name_txt");
         _loc5_.caption = param1.roomName;
         new OpenRoomTool(var_56,var_53,_loc5_,param1.isPublic,param1.roomId);
         _loc5_.color = _loc4_;
         var _loc6_:ITextWindow = ITextWindow(_loc3_.findChildByName("time_txt"));
         _loc6_.text = getFormattedTime(param1.enterHour,param1.enterMinute);
         var _loc7_:ITextWindow = ITextWindow(_loc3_.findChildByName("view_room_txt"));
         new OpenRoomInSpectatorMode(var_53,_loc7_,param1.isPublic,param1.roomId);
         _loc7_.color = _loc4_;
         _list.addListItem(_loc3_);
      }
      
      public function show() : void
      {
         var_1924 = IWindowContainer(var_53.getXmlWindow("roomvisits_row"));
         var_418 = new Timer(300,1);
         var_418.addEventListener(TimerEvent.TIMER,onResizeTimer);
         var_53.messageHandler.addRoomVisitsListener(this);
         var_53.connection.send(new GetRoomVisitsMessageComposer(_userId));
         var_56 = IFrameWindow(var_53.getXmlWindow("roomvisits_frame"));
         _list = IItemListWindow(var_56.findChildByName("visits_list"));
         var_56.procedure = onWindow;
         var _loc1_:IWindow = var_56.findChildByTag("close");
         _loc1_.procedure = onClose;
      }
      
      public function getFrame() : IFrameWindow
      {
         return var_56;
      }
      
      public function getType() : int
      {
         return WindowTracker.const_1234;
      }
   }
}
