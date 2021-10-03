package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RespectNotificationMessageParser implements IMessageParser
   {
       
      
      private var _userId:int = 0;
      
      private var var_2005:int = 0;
      
      public function RespectNotificationMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _userId = param1.readInteger();
         var_2005 = param1.readInteger();
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get respectTotal() : int
      {
         return var_2005;
      }
   }
}
