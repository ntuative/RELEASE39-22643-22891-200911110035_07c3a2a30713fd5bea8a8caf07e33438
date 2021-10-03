package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
   public class FurniData
   {
       
      
      private var var_1666:String;
      
      private var var_845:String;
      
      private var var_1750:Boolean;
      
      private var var_1670:int;
      
      private var var_1669:Boolean;
      
      private var var_1472:String = "";
      
      private var _category:int;
      
      private var var_1199:int;
      
      private var var_1671:Boolean;
      
      private var var_1496:int = -1;
      
      private var _objId:int;
      
      private var var_1668:int;
      
      public function FurniData(param1:int, param2:String, param3:int, param4:int, param5:int, param6:String, param7:Boolean, param8:Boolean, param9:Boolean, param10:int)
      {
         super();
         var_1670 = param1;
         var_845 = param2;
         _objId = param3;
         var_1199 = param4;
         _category = param5;
         var_1666 = param6;
         var_1750 = param7;
         var_1669 = param8;
         var_1671 = param9;
         var_1668 = param10;
      }
      
      public function get classId() : int
      {
         return var_1199;
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function get isGroupable() : Boolean
      {
         return var_1750;
      }
      
      public function get stripId() : int
      {
         return var_1670;
      }
      
      public function get stuffData() : String
      {
         return var_1666;
      }
      
      public function get songId() : int
      {
         return var_1496;
      }
      
      public function setSongData(param1:String, param2:int) : void
      {
         var_1472 = param1;
         var_1496 = param2;
      }
      
      public function get expiryTime() : int
      {
         return var_1668;
      }
      
      public function get itemType() : String
      {
         return var_845;
      }
      
      public function get method_4() : int
      {
         return _objId;
      }
      
      public function get slotId() : String
      {
         return var_1472;
      }
      
      public function get isTradeable() : Boolean
      {
         return var_1671;
      }
      
      public function get isRecyclable() : Boolean
      {
         return var_1669;
      }
   }
}
