package com.sulake.habbo.widget.events
{
   public class RoomWidgetDoorbellEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_683:String = "RWDE_RINGING";
      
      public static const const_105:String = "RWDE_REJECTED";
       
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var _userName:String = "";
      
      public function RoomWidgetDoorbellEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _userName = param2;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get roomCategory() : int
      {
         return _roomCategory;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
   }
}
