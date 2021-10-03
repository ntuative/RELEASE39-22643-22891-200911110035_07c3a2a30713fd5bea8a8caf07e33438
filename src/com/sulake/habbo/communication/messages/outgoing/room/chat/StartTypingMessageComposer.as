package com.sulake.habbo.communication.messages.outgoing.room.chat
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class StartTypingMessageComposer implements IMessageComposer
   {
       
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      public function StartTypingMessageComposer(param1:int = 0, param2:int = 0)
      {
         super();
         _roomId = param1;
         _roomCategory = param2;
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
