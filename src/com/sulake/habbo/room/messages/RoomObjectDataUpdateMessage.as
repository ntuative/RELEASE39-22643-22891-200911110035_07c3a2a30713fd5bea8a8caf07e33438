package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class RoomObjectDataUpdateMessage extends RoomObjectUpdateMessage
   {
       
      
      private var _state:int;
      
      private var _data:String;
      
      public function RoomObjectDataUpdateMessage(param1:int, param2:String)
      {
         super(null,null);
         _state = param1;
         _data = param2;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get data() : String
      {
         return _data;
      }
   }
}
