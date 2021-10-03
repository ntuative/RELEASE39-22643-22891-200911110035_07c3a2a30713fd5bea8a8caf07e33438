package com.sulake.core.communication.protocol
{
   import com.sulake.core.communication.util.Short;
   import flash.utils.ByteArray;
   
   public interface IProtocolDecoder
   {
       
      
      function getID(param1:ByteArray) : int;
      
      function readBoolean(param1:ByteArray) : Boolean;
      
      function readShort(param1:ByteArray) : Short;
      
      function readString(param1:ByteArray) : String;
      
      function readInteger(param1:ByteArray) : int;
      
      function decode(param1:ByteArray) : void;
      
      function dispose() : void;
   }
}
