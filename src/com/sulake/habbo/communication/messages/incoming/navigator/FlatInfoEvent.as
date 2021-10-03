package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.FlatInfoMessageParser;
   
   public class FlatInfoEvent extends MessageEvent implements IMessageEvent
   {
       
      
      public function FlatInfoEvent(param1:Function)
      {
         super(param1,FlatInfoMessageParser);
      }
      
      public function getParser() : FlatInfoMessageParser
      {
         return this.var_21 as FlatInfoMessageParser;
      }
   }
}
