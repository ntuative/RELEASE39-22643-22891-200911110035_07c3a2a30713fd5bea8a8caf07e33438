package com.sulake.habbo.widget.messages
{
   public class RoomWidgetFurniActionMessage extends RoomWidgetMessage
   {
      
      public static const const_236:String = "RWFAM_MOVE";
      
      public static const const_604:String = "RWFUAM_ROTATE";
      
      public static const const_494:String = "RWFAM_PICKUP";
       
      
      private var var_1776:int = 0;
      
      private var var_1777:int = 0;
      
      public function RoomWidgetFurniActionMessage(param1:String, param2:int, param3:int)
      {
         super(param1);
         var_1776 = param2;
         var_1777 = param3;
      }
      
      public function get furniId() : int
      {
         return var_1776;
      }
      
      public function get furniCategory() : int
      {
         return var_1777;
      }
   }
}
