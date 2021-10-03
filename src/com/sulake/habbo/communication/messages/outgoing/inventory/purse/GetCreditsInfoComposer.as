package com.sulake.habbo.communication.messages.outgoing.inventory.purse
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetCreditsInfoComposer implements IMessageComposer
   {
       
      
      public function GetCreditsInfoComposer()
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
