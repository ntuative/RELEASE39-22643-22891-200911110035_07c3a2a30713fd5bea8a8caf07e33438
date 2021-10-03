package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectEvent;
   
   public class RoomObjectMoveEvent extends RoomObjectEvent
   {
      
      public static const const_394:String = "ROME_OBJECT_REMOVED";
      
      public static const POSITION_CHANGED:String = "ROME_POSITION_CHANGED";
       
      
      public function RoomObjectMoveEvent(param1:String, param2:int, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
   }
}
