package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionDoorbellEvent extends RoomSessionEvent
   {
      
      public static const const_92:String = "RSDE_DOORBELL";
      
      public static const const_105:String = "RSDE_REJECTED";
       
      
      private var _userName:String = "";
      
      public function RoomSessionDoorbellEvent(param1:String, param2:IRoomSession, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param4,param5);
         _userName = param3;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
   }
}
