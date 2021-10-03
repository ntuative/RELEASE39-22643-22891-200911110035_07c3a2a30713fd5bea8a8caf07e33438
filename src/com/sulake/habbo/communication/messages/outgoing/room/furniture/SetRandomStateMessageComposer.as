package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class SetRandomStateMessageComposer implements IMessageComposer
   {
       
      
      private var var_28:int = 0;
      
      private var _roomId:int;
      
      private var _roomCategory:int = 0;
      
      private var var_154:int;
      
      public function SetRandomStateMessageComposer(param1:int, param2:int = 0, param3:int = 0, param4:int = 0)
      {
         super();
         var_154 = param1;
         var_28 = param2;
         _roomId = param3;
         _roomCategory = param4;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_154,var_28];
      }
   }
}
