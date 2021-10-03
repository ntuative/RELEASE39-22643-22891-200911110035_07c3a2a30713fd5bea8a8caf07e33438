package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarCarryObjectUpdateMessage extends RoomObjectUpdateStateMessage
   {
       
      
      private var var_845:int;
      
      private var var_1012:String;
      
      public function RoomObjectAvatarCarryObjectUpdateMessage(param1:int, param2:String)
      {
         super();
         var_845 = param1;
         var_1012 = param2;
      }
      
      public function get itemType() : int
      {
         return var_845;
      }
      
      public function get itemName() : String
      {
         return var_1012;
      }
   }
}
