package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCloseParser;
   
   public class TradingCloseEvent extends MessageEvent
   {
       
      
      public function TradingCloseEvent(param1:Function, param2:Class)
      {
         super(param1,param2);
      }
      
      public function getParser() : TradingCloseParser
      {
         return var_21 as TradingCloseParser;
      }
      
      public function get userID() : int
      {
         return getParser().userID;
      }
   }
}
