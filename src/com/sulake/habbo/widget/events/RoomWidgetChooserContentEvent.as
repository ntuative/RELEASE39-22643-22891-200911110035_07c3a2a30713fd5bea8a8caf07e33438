package com.sulake.habbo.widget.events
{
   public class RoomWidgetChooserContentEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_453:String = "RWCCE_USER_CHOOSER_CONTENT";
      
      public static const const_452:String = "RWCCE_FURNI_CHOOSER_CONTENT";
       
      
      private var _items:Array;
      
      private var var_1581:Boolean;
      
      public function RoomWidgetChooserContentEvent(param1:String, param2:Array, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         _items = param2.slice();
         var_1581 = param3;
      }
      
      public function get items() : Array
      {
         return _items;
      }
      
      public function get isAnyRoomController() : Boolean
      {
         return var_1581;
      }
   }
}
