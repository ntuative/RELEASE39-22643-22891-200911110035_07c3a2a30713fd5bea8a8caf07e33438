package com.sulake.habbo.widget.events
{
   public class RoomWidgetStickieDataUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_502:String = "RWSDUE_STICKIE_DATA";
       
      
      private var var_197:String;
      
      private var var_618:String;
      
      private var var_1375:String;
      
      private var var_154:int = -1;
      
      private var _controller:Boolean;
      
      public function RoomWidgetStickieDataUpdateEvent(param1:String, param2:int, param3:String, param4:String, param5:String, param6:Boolean, param7:Boolean = false, param8:Boolean = false)
      {
         super(param1,param7,param8);
         var_154 = param2;
         var_1375 = param3;
         var_197 = param4;
         var_618 = param5;
         _controller = param6;
      }
      
      public function get objectType() : String
      {
         return var_1375;
      }
      
      public function get colorHex() : String
      {
         return var_618;
      }
      
      public function get text() : String
      {
         return var_197;
      }
      
      public function get objectId() : int
      {
         return var_154;
      }
      
      public function get method_1() : Boolean
      {
         return _controller;
      }
   }
}
