package com.sulake.room.events
{
   import flash.events.Event;
   
   public class RoomObjectEvent extends Event
   {
       
      
      private var var_1375:String = "";
      
      private var var_154:int = 0;
      
      public function RoomObjectEvent(param1:String, param2:int, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         var_154 = param2;
         var_1375 = param3;
      }
      
      public function get objectType() : String
      {
         return var_1375;
      }
      
      public function get objectId() : int
      {
         return var_154;
      }
   }
}
