package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class PresentOpenMessageComposer implements IMessageComposer
   {
       
      
      private var var_154:int;
      
      public function PresentOpenMessageComposer(param1:int)
      {
         super();
         var_154 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_154];
      }
   }
}
