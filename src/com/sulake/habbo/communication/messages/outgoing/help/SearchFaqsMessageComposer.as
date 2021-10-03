package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class SearchFaqsMessageComposer implements IMessageComposer
   {
       
      
      private var var_1948:String;
      
      public function SearchFaqsMessageComposer(param1:String)
      {
         super();
         var_1948 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_1948];
      }
   }
}
