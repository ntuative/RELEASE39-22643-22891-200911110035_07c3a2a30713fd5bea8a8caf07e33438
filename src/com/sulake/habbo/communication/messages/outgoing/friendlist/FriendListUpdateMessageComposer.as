package com.sulake.habbo.communication.messages.outgoing.friendlist
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class FriendListUpdateMessageComposer implements IMessageComposer
   {
       
      
      public function FriendListUpdateMessageComposer()
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
