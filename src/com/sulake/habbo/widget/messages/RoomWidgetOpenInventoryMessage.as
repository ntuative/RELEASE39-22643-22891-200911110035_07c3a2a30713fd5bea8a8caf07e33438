package com.sulake.habbo.widget.messages
{
   public class RoomWidgetOpenInventoryMessage extends RoomWidgetMessage
   {
      
      public static const const_772:String = "inventory_badges";
      
      public static const const_1194:String = "inventory_clothes";
      
      public static const const_1120:String = "inventory_furniture";
      
      public static const const_642:String = "RWGOI_MESSAGE_OPEN_INVENTORY";
      
      public static const const_744:String = "inventory_effects";
       
      
      private var var_1638:String;
      
      public function RoomWidgetOpenInventoryMessage(param1:String)
      {
         super(const_642);
         var_1638 = param1;
      }
      
      public function get inventoryType() : String
      {
         return var_1638;
      }
   }
}
