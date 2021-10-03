package com.sulake.habbo.widget.messages
{
   public class RoomWidgetEcotronBoxOpenedMessage extends RoomWidgetMessage
   {
      
      public static const const_1108:String = "RWEBOM_ECOTRONBOX_OPENED";
       
      
      private var var_1199:int;
      
      private var var_845:String;
      
      public function RoomWidgetEcotronBoxOpenedMessage(param1:String, param2:String, param3:int)
      {
         super(param1);
         var_845 = param2;
         var_1199 = param3;
      }
      
      public function get classId() : int
      {
         return var_1199;
      }
      
      public function get itemType() : String
      {
         return var_845;
      }
   }
}
