package com.sulake.habbo.widget.messages
{
   public class RoomWidgetDanceMessage extends RoomWidgetMessage
   {
      
      public static const const_539:String = "RWCM_MESSAGE_DANCE";
      
      public static const const_866:int = 0;
      
      public static const const_1218:Array = [2,3,4];
       
      
      private var var_85:int = 0;
      
      public function RoomWidgetDanceMessage(param1:int)
      {
         super(const_539);
         var_85 = param1;
      }
      
      public function get style() : int
      {
         return var_85;
      }
   }
}
