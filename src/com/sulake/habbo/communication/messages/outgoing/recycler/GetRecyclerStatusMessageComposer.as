package com.sulake.habbo.communication.messages.outgoing.recycler
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetRecyclerStatusMessageComposer implements IMessageComposer
   {
       
      
      public function GetRecyclerStatusMessageComposer()
      {
         super();
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
