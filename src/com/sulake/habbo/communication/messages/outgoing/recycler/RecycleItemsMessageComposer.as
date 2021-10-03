package com.sulake.habbo.communication.messages.outgoing.recycler
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class RecycleItemsMessageComposer implements IMessageComposer
   {
       
      
      private var var_679:Array;
      
      public function RecycleItemsMessageComposer(param1:Array)
      {
         super();
         var_679 = new Array();
         var_679.push(param1.length);
         var_679 = var_679.concat(param1);
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return var_679;
      }
   }
}
