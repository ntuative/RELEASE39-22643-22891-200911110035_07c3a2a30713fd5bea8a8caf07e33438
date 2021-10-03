package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionUserBadgesEvent extends RoomSessionEvent
   {
      
      public static const const_106:String = "RSUBE_BADGES";
       
      
      private var _userId:int = 0;
      
      private var var_164:Array;
      
      public function RoomSessionUserBadgesEvent(param1:IRoomSession, param2:int, param3:Array, param4:Boolean = false, param5:Boolean = false)
      {
         var_164 = [];
         super(const_106,param1,param4,param5);
         _userId = param2;
         var_164 = param3;
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
