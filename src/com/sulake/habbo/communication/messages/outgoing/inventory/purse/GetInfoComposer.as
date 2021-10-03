package com.sulake.habbo.communication.messages.outgoing.inventory.purse
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetInfoComposer implements IMessageComposer
   {
       
      
      public function GetInfoComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return new Array();
      }
      
      public function dispose() : void
      {
      }
   }
}
