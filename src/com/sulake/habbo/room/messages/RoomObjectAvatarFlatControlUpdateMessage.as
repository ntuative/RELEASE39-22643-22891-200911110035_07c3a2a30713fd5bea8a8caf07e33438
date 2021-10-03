package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarFlatControlUpdateMessage extends RoomObjectUpdateStateMessage
   {
       
      
      private var var_2015:String;
      
      private var var_2014:Boolean = false;
      
      public function RoomObjectAvatarFlatControlUpdateMessage(param1:String)
      {
         super();
         var_2015 = param1;
         if(param1 != null && param1.indexOf("useradmin") != -1)
         {
            var_2014 = true;
         }
      }
      
      public function get rawData() : String
      {
         return var_2015;
      }
      
      public function get isAdmin() : Boolean
      {
         return var_2014;
      }
   }
}
