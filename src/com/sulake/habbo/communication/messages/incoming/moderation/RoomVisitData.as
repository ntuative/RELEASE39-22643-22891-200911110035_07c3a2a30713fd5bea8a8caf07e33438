package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class RoomVisitData
   {
       
      
      private var var_603:String;
      
      private var var_1465:int;
      
      private var var_1261:Boolean;
      
      private var _roomId:int;
      
      private var var_1466:int;
      
      public function RoomVisitData(param1:IMessageDataWrapper)
      {
         super();
         var_1261 = param1.readBoolean();
         _roomId = param1.readInteger();
         var_603 = param1.readString();
         var_1466 = param1.readInteger();
         var_1465 = param1.readInteger();
      }
      
      public function get isPublic() : Boolean
      {
         return var_1261;
      }
      
      public function get roomName() : String
      {
         return var_603;
      }
      
      public function get enterMinute() : int
      {
         return var_1465;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get enterHour() : int
      {
         return var_1466;
      }
   }
}
