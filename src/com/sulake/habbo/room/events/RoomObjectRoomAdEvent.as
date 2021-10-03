package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectEvent;
   
   public class RoomObjectRoomAdEvent extends RoomObjectEvent
   {
      
      public static const const_306:String = "RORAE_ROOM_AD_TOOLTIP_SHOW";
      
      public static const const_267:String = "RORAE_ROOM_AD_TOOLTIP_HIDE";
       
      
      public function RoomObjectRoomAdEvent(param1:String, param2:int, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
   }
}
