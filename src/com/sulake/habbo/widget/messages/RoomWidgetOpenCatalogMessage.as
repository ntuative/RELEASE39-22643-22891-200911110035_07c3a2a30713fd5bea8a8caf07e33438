package com.sulake.habbo.widget.messages
{
   public class RoomWidgetOpenCatalogMessage extends RoomWidgetMessage
   {
      
      public static const const_420:String = "RWOCM_CLUB_MAIN";
      
      public static const const_610:String = "RWGOI_MESSAGE_OPEN_CATALOG";
       
      
      private var var_1484:String = "";
      
      public function RoomWidgetOpenCatalogMessage(param1:String)
      {
         super(const_610);
         var_1484 = param1;
      }
      
      public function get pageKey() : String
      {
         return var_1484;
      }
   }
}
