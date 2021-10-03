package com.sulake.habbo.communication.messages.outgoing.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetAchievementsComposer implements IMessageComposer
   {
       
      
      public function GetAchievementsComposer()
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
