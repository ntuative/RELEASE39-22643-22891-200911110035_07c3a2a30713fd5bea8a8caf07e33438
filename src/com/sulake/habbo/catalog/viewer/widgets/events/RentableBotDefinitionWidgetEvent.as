package com.sulake.habbo.catalog.viewer.widgets.events
{
   import com.sulake.core.utils.Map;
   import flash.events.Event;
   
   public class RentableBotDefinitionWidgetEvent extends Event
   {
       
      
      private var var_1287:Map;
      
      public function RentableBotDefinitionWidgetEvent(param1:Map, param2:Boolean = false, param3:Boolean = false)
      {
         super(WidgetEvent.CWE_RENTABLE_BOT_DEFINITIONS,param2,param3);
         var_1287 = param1;
      }
      
      public function get botFigureData() : Map
      {
         return var_1287;
      }
   }
}
