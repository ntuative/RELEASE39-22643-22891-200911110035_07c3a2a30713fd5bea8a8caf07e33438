package com.sulake.habbo.communication.messages.outgoing.handshake
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class PongMessageComposer implements IMessageComposer
   {
       
      
      public function PongMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return [];
      }
      
      public function dispose() : void
      {
      }
   }
}
