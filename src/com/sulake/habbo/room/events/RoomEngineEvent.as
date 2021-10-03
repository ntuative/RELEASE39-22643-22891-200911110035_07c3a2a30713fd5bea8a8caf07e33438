package com.sulake.habbo.room.events
{
   import flash.events.Event;
   
   public class RoomEngineEvent extends Event
   {
      
      public static const const_625:String = "REE_INITIALIZED";
      
      public static const const_480:String = "REE_DISPOSED";
      
      public static const const_590:String = "REE_ENGINE_INITIALIZED";
       
      
      private var _roomId:int;
      
      private var _roomCategory:int;
      
      public function RoomEngineEvent(param1:String, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         _roomId = param2;
         _roomCategory = param3;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get roomCategory() : int
      {
         return _roomCategory;
      }
   }
}
