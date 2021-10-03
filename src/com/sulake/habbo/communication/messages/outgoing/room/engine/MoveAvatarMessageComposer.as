package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class MoveAvatarMessageComposer implements IMessageComposer
   {
       
      
      private var _roomId:int;
      
      private var _roomCategory:int = 0;
      
      private var var_88:int;
      
      private var _y:int;
      
      public function MoveAvatarMessageComposer(param1:int, param2:int, param3:int = 0, param4:int = 0)
      {
         super();
         var_88 = param1;
         _y = param2;
         _roomId = param3;
         _roomCategory = param4;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_88,_y];
      }
   }
}
