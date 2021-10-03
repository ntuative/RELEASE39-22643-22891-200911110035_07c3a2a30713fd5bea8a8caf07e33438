package com.sulake.habbo.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetInterstitialUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const COMPLETE:String = "RWIUE_COMPLETE";
      
      public static const const_87:String = "RWIUE_SHOW";
       
      
      private var _image:BitmapData;
      
      private var var_1372:String;
      
      public function RoomWidgetInterstitialUpdateEvent(param1:String, param2:BitmapData, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         _image = param2;
         var_1372 = param3;
      }
      
      public function get clickUrl() : String
      {
         return var_1372;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
   }
}
