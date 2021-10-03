package com.sulake.habbo.inventory.events
{
   import flash.events.Event;
   
   public class HabboInventoryHabboClubEvent extends Event
   {
      
      public static const const_569:String = "HIHCE_HABBO_CLUB_CHANGED";
       
      
      public function HabboInventoryHabboClubEvent(param1:Boolean = false, param2:Boolean = false)
      {
         super(const_569,param1,param2);
      }
   }
}
