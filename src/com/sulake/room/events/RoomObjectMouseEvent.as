package com.sulake.room.events
{
   public class RoomObjectMouseEvent extends RoomObjectEvent
   {
      
      public static const const_1324:String = "ROE_MOUSE_LEAVE";
      
      public static const const_1419:String = "ROE_MOUSE_ENTER";
      
      public static const const_451:String = "ROE_MOUSE_MOVE";
      
      public static const const_1468:String = "ROE_MOUSE_DOUBLE_CLICK";
      
      public static const const_180:String = "ROE_MOUSE_CLICK";
      
      public static const const_334:String = "ROE_MOUSE_DOWN";
       
      
      private var var_1479:Boolean;
      
      private var var_1476:Boolean;
      
      private var var_1477:Boolean;
      
      private var var_1478:Boolean;
      
      public function RoomObjectMouseEvent(param1:String, param2:int, param3:String, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false)
      {
         super(param1,param2,param3,param8,param9);
         var_1477 = param4;
         var_1478 = param5;
         var_1479 = param6;
         var_1476 = param7;
      }
      
      public function get buttonDown() : Boolean
      {
         return var_1476;
      }
      
      public function get altKey() : Boolean
      {
         return var_1477;
      }
      
      public function get ctrlKey() : Boolean
      {
         return var_1478;
      }
      
      public function get shiftKey() : Boolean
      {
         return var_1479;
      }
   }
}
