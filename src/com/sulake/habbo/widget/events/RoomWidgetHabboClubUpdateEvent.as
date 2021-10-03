package com.sulake.habbo.widget.events
{
   public class RoomWidgetHabboClubUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_210:String = "RWBIUE_HABBO_CLUB";
       
      
      private var var_1846:Boolean = false;
      
      private var var_1843:int = 0;
      
      private var var_1844:int = 0;
      
      private var var_1845:int = 0;
      
      public function RoomWidgetHabboClubUpdateEvent(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean = false, param6:Boolean = false)
      {
         super(const_210,param5,param6);
         var_1845 = param1;
         var_1844 = param2;
         var_1843 = param3;
         var_1846 = param4;
      }
      
      public function get pastPeriods() : int
      {
         return var_1843;
      }
      
      public function get periodsLeft() : int
      {
         return var_1844;
      }
      
      public function get daysLeft() : int
      {
         return var_1845;
      }
      
      public function get allowClubDances() : Boolean
      {
         return var_1846;
      }
   }
}
