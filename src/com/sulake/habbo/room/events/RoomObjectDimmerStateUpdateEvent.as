package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectEvent;
   
   public class RoomObjectDimmerStateUpdateEvent extends RoomObjectEvent
   {
      
      public static const const_60:String = "RODSUE_DIMMER_STATE";
       
      
      private var var_879:int;
      
      private var _color:uint;
      
      private var var_878:int;
      
      private var var_1800:int;
      
      private var _state:int;
      
      public function RoomObjectDimmerStateUpdateEvent(param1:int, param2:String, param3:int, param4:int, param5:int, param6:uint, param7:int, param8:Boolean = false, param9:Boolean = false)
      {
         super(const_60,param1,param2,param8,param9);
         _state = param3;
         var_1800 = param4;
         var_879 = param5;
         _color = param6;
         var_878 = param7;
      }
      
      public function get brightness() : uint
      {
         return var_878;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get effectId() : int
      {
         return var_879;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get presetId() : int
      {
         return var_1800;
      }
   }
}
