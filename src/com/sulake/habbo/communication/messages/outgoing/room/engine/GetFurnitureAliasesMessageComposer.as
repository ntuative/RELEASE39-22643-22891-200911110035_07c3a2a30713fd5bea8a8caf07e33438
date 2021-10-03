package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetFurnitureAliasesMessageComposer implements IMessageComposer
   {
       
      
      public function GetFurnitureAliasesMessageComposer()
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
