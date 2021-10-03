package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarFigureUpdateMessage extends RoomObjectUpdateStateMessage
   {
       
      
      private var var_1836:String;
      
      private var var_828:String;
      
      public function RoomObjectAvatarFigureUpdateMessage(param1:String, param2:String = "")
      {
         super();
         var_828 = param1;
         var_1836 = param2;
      }
      
      public function get race() : String
      {
         return var_1836;
      }
      
      public function get figure() : String
      {
         return var_828;
      }
   }
}
