package com.sulake.habbo.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetEcotronBoxDataUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_76:String = "RWEBDUE_CONTENTS";
      
      public static const const_57:String = "RWEBDUE_PACKAGEINFO";
       
      
      private var var_197:String;
      
      private var var_1446:BitmapData;
      
      private var var_154:int = -1;
      
      private var _controller:Boolean;
      
      public function RoomWidgetEcotronBoxDataUpdateEvent(param1:String, param2:int, param3:String, param4:Boolean = false, param5:BitmapData = null, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param6,param7);
         var_154 = param2;
         var_197 = param3;
         _controller = param4;
         var_1446 = param5;
      }
      
      public function get iconBitmapData() : BitmapData
      {
         return var_1446;
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
