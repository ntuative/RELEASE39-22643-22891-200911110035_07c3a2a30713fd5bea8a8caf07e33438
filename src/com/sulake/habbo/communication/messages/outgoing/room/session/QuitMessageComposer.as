package com.sulake.habbo.communication.messages.outgoing.room.session
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class QuitMessageComposer implements IMessageComposer
   {
       
      
      public function QuitMessageComposer()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return true;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return new Array();
      }
   }
}
