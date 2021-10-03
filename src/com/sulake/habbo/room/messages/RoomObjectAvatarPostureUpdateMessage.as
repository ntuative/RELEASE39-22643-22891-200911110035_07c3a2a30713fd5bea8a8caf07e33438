package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarPostureUpdateMessage extends RoomObjectUpdateStateMessage
   {
       
      
      private var var_1566:String;
      
      private var var_736:String;
      
      public function RoomObjectAvatarPostureUpdateMessage(param1:String, param2:String = "")
      {
         super();
         var_1566 = param1;
         var_736 = param2;
      }
      
      public function get postureType() : String
      {
         return var_1566;
      }
      
      public function get parameter() : String
      {
         return var_736;
      }
   }
}
