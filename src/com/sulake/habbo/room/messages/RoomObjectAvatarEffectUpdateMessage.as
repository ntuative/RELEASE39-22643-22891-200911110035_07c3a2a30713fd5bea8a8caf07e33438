package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarEffectUpdateMessage extends RoomObjectUpdateStateMessage
   {
       
      
      private var var_167:int;
      
      public function RoomObjectAvatarEffectUpdateMessage(param1:int = 0)
      {
         super();
         var_167 = param1;
      }
      
      public function get effect() : int
      {
         return var_167;
      }
   }
}
