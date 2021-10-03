package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class LatencyPingRequestMessageComposer implements IMessageComposer
   {
       
      
      private var _id:int = 0;
      
      public function LatencyPingRequestMessageComposer(param1:int)
      {
         super();
         _id = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [_id];
      }
      
      public function dispose() : void
      {
      }
   }
}
