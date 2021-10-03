package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetInventoryMessageParser;
   
   public class PetInventoryEvent extends MessageEvent
   {
       
      
      public function PetInventoryEvent(param1:Function)
      {
         super(param1,PetInventoryMessageParser);
      }
      
      public function getParser() : PetInventoryMessageParser
      {
         return var_21 as PetInventoryMessageParser;
      }
   }
}
