package com.sulake.habbo.widget.events
{
   public class RoomWidgetUserBadgesUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_106:String = "RWUBUE_USER_BADGES";
       
      
      private var _userId:int;
      
      private var var_164:Array;
      
      public function RoomWidgetUserBadgesUpdateEvent(param1:int, param2:Array, param3:Boolean = false, param4:Boolean = false)
      {
         super(const_106,param3,param4);
         _userId = param1;
         var_164 = param2;
      }
      
      public function get badges() : Array
      {
         return var_164;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
   }
}
