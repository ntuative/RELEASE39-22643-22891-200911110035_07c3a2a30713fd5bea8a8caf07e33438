package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class TradingCloseParser implements IMessageParser
   {
       
      
      private var _userId:int;
      
      public function TradingCloseParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _userId = param1.readInteger();
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get userID() : int
      {
         return _userId;
      }
   }
}
