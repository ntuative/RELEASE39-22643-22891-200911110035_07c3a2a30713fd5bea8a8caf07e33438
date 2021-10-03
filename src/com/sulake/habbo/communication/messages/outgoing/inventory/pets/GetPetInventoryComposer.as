package com.sulake.habbo.communication.messages.outgoing.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetPetInventoryComposer implements IMessageComposer
   {
       
      
      public function GetPetInventoryComposer()
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
