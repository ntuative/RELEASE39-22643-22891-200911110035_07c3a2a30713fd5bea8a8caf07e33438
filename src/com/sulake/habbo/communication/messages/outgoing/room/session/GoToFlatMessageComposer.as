package com.sulake.habbo.communication.messages.outgoing.room.session
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GoToFlatMessageComposer implements IMessageComposer
   {
       
      
      private var _roomId:int;
      
      private var _roomCategory:int = 0;
      
      public function GoToFlatMessageComposer(param1:int, param2:int = 0)
      {
         super();
         _roomId = param1;
         _roomCategory = param2;
      }
      
      public function getMessageArray() : Array
      {
         return [_roomId];
      }
      
      public function dispose() : void
      {
      }
   }
}
