package com.sulake.habbo.widget.events
{
   public class RoomWidgetRoomQueueUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_347:String = "RWRQUE_SPECTATOR_QUEUE_STATUS";
      
      public static const const_317:String = "RWRQUE_VISITOR_QUEUE_STATUS";
       
      
      private var var_753:int;
      
      private var var_318:Boolean;
      
      private var var_1556:Boolean;
      
      private var var_1394:Boolean;
      
      public function RoomWidgetRoomQueueUpdateEvent(param1:String, param2:int, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param6,param7);
         var_753 = param2;
         var_1556 = param3;
         var_318 = param4;
         var_1394 = param5;
      }
      
      public function get position() : int
      {
         return var_753;
      }
      
      public function get isActive() : Boolean
      {
         return var_318;
      }
      
      public function get isClubQueue() : Boolean
      {
         return var_1394;
      }
      
      public function get hasHabboClub() : Boolean
      {
         return var_1556;
      }
   }
}
