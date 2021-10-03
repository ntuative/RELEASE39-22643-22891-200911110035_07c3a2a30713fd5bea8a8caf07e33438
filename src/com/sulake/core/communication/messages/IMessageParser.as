package com.sulake.core.communication.messages
{
   public interface IMessageParser
   {
       
      
      function parse(param1:IMessageDataWrapper) : Boolean;
      
      function flush() : Boolean;
   }
}
