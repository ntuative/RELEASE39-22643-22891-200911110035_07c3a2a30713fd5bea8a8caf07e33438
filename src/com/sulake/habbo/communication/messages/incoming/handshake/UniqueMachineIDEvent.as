package com.sulake.habbo.communication.messages.incoming.handshake
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.UniqueMachineIDParser;
   
   public class UniqueMachineIDEvent extends MessageEvent implements IMessageEvent
   {
       
      
      public function UniqueMachineIDEvent(param1:Function)
      {
         super(param1,UniqueMachineIDParser);
      }
      
      public function get machineID() : String
      {
         return getParser().machineID;
      }
      
      private function getParser() : UniqueMachineIDParser
      {
         return this.var_21 as UniqueMachineIDParser;
      }
   }
}
