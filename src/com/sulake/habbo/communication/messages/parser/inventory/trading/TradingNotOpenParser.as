package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class TradingNotOpenParser implements IMessageParser
   {
       
      
      public function TradingNotOpenParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
   }
}
