package com.sulake.core.communication.protocol
{
   import flash.utils.ByteArray;
   
   public interface IProtocol
   {
       
      
      function getMessages(param1:ByteArray, param2:Array) : uint;
      
      function get decoder() : IProtocolDecoder;
      
      function get encoder() : IProtocolEncoder;
      
      function dispose() : void;
   }
}
