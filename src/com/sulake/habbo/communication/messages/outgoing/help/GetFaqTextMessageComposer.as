package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetFaqTextMessageComposer implements IMessageComposer
   {
       
      
      private var var_1211:int;
      
      public function GetFaqTextMessageComposer(param1:int)
      {
         super();
         var_1211 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_1211];
      }
   }
}
