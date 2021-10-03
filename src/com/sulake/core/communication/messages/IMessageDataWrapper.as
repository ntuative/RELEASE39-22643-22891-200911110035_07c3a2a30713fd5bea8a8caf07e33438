package com.sulake.core.communication.messages
{
   import com.sulake.core.communication.util.Short;
   
   public interface IMessageDataWrapper
   {
       
      
      function readInteger() : int;
      
      function readBoolean() : Boolean;
      
      function readShort() : Short;
      
      function readString() : String;
   }
}
