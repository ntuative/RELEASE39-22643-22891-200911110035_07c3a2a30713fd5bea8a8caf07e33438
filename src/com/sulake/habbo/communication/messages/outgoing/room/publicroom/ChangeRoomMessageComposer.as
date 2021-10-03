package com.sulake.habbo.communication.messages.outgoing.room.publicroom
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class ChangeRoomMessageComposer implements IMessageComposer
   {
       
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var var_1654:int = 0;
      
      public function ChangeRoomMessageComposer(param1:int, param2:int = 0, param3:int = 0)
      {
         super();
         _roomId = param2;
         _roomCategory = param3;
         var_1654 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_1654];
      }
      
      public function dispose() : void
      {
      }
   }
}
