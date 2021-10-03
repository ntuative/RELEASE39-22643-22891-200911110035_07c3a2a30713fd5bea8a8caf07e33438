package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class CfhChatlogData
   {
       
      
      private var var_966:int;
      
      private var var_1968:int;
      
      private var var_1419:int;
      
      private var var_118:RoomChatlogData;
      
      public function CfhChatlogData(param1:IMessageDataWrapper)
      {
         super();
         var_1419 = param1.readInteger();
         var_1968 = param1.readInteger();
         var_966 = param1.readInteger();
         var_118 = new RoomChatlogData(param1);
         Logger.log("READ CFHCHATLOGDATA: callId: " + var_1419);
      }
      
      public function get reportedUserId() : int
      {
         return var_966;
      }
      
      public function get callerUserId() : int
      {
         return var_1968;
      }
      
      public function get callId() : int
      {
         return var_1419;
      }
      
      public function get room() : RoomChatlogData
      {
         return var_118;
      }
   }
}
