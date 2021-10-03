package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class CancelEventMessageComposer implements IMessageComposer
   {
       
      
      public function CancelEventMessageComposer()
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
