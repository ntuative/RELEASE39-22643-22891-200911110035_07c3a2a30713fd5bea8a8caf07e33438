package com.sulake.habbo.widget.events
{
   public class RoomWidgetUpdateEffectsUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_627:String = "RWUEUE_UPDATE_EFFECTS";
       
      
      private var var_251:Array;
      
      public function RoomWidgetUpdateEffectsUpdateEvent(param1:Array = null, param2:Boolean = false, param3:Boolean = false)
      {
         super(const_627,param2,param3);
         var_251 = param1;
      }
      
      public function get effects() : Array
      {
         return var_251;
      }
   }
}
