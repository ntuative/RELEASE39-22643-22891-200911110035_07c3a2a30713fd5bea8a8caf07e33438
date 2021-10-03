package com.sulake.habbo.widget.messages
{
   public class RoomWidgetMessage
   {
      
      public static const const_1410:String = "RWM_MESSAGE_TEST";
       
      
      private var _type:String = "";
      
      public function RoomWidgetMessage(param1:String)
      {
         super();
         _type = param1;
      }
      
      public function get type() : String
      {
         return _type;
      }
   }
}
