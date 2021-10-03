package com.sulake.habbo.communication.messages.parser.poll
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class PollErrorParser implements IMessageParser
   {
       
      
      public function PollErrorParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         return false;
      }
      
      public function flush() : Boolean
      {
         return false;
      }
   }
}
