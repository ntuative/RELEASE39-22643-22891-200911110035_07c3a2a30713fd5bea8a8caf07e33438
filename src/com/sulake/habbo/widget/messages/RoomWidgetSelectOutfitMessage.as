package com.sulake.habbo.widget.messages
{
   public class RoomWidgetSelectOutfitMessage extends RoomWidgetMessage
   {
      
      public static const const_882:String = "select_outfit";
       
      
      private var var_1936:int;
      
      public function RoomWidgetSelectOutfitMessage(param1:int)
      {
         super(const_882);
         var_1936 = param1;
      }
      
      public function get outfitId() : int
      {
         return var_1936;
      }
   }
}
