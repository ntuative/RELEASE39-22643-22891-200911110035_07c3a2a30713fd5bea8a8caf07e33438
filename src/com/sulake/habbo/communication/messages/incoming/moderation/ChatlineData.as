package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class ChatlineData
   {
       
      
      private var var_1373:String;
      
      private var var_1717:int;
      
      private var var_1716:int;
      
      private var var_1715:int;
      
      private var var_1718:String;
      
      public function ChatlineData(param1:IMessageDataWrapper)
      {
         super();
         var_1717 = param1.readInteger();
         var_1715 = param1.readInteger();
         var_1716 = param1.readInteger();
         var_1718 = param1.readString();
         var_1373 = param1.readString();
      }
      
      public function get msg() : String
      {
         return var_1373;
      }
      
      public function get hour() : int
      {
         return var_1717;
      }
      
      public function get minute() : int
      {
         return var_1715;
      }
      
      public function get chatterName() : String
      {
         return var_1718;
      }
      
      public function get chatterId() : int
      {
         return var_1716;
      }
   }
}
