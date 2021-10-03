package com.sulake.habbo.communication.messages.outgoing.inventory.purse
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetClubInfoComposer implements IMessageComposer
   {
       
      
      public function GetClubInfoComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("club_info");
         return _loc1_;
      }
      
      public function dispose() : void
      {
      }
   }
}
