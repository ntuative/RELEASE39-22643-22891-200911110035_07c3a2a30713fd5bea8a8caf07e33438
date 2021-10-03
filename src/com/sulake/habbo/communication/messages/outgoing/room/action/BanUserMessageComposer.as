package com.sulake.habbo.communication.messages.outgoing.room.action
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class BanUserMessageComposer implements IMessageComposer
   {
       
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var _userId:int;
      
      public function BanUserMessageComposer(param1:int, param2:int = 0, param3:int = 0)
      {
         super();
         _userId = param1;
         _roomId = param2;
         _roomCategory = param3;
      }
      
      public function getMessageArray() : Array
      {
         return [_userId];
      }
      
      public function dispose() : void
      {
      }
   }
}
