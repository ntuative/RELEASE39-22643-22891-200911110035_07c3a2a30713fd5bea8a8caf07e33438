package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class UnacceptTradingComposer implements IMessageComposer
   {
       
      
      public function UnacceptTradingComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return new Array();
      }
      
      public function dispose() : void
      {
      }
   }
}
