package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   public class ItemDataStructure
   {
       
      
      private var var_1985:int;
      
      private var var_1980:int;
      
      private var var_845:String;
      
      private var var_1775:int;
      
      private var var_1983:String;
      
      private var var_1979:int;
      
      private var var_1986:int;
      
      private var _category:int;
      
      private var var_1987:int;
      
      private var var_1982:int;
      
      private var var_1984:int;
      
      private var var_1981:Boolean;
      
      public function ItemDataStructure(param1:int, param2:String, param3:int, param4:int, param5:int, param6:String, param7:int, param8:int, param9:int, param10:int, param11:Boolean, param12:int)
      {
         super();
         var_1775 = param1;
         var_845 = param2;
         var_1980 = param3;
         var_1984 = param4;
         _category = param5;
         var_1983 = param6;
         var_1979 = param7;
         var_1985 = param8;
         var_1982 = param9;
         var_1986 = param10;
         var_1981 = param11;
         var_1987 = param12;
      }
      
      public function get itemTypeID() : int
      {
         return var_1984;
      }
      
      public function get groupable() : Boolean
      {
         return var_1981;
      }
      
      public function get creationMonth() : int
      {
         return var_1982;
      }
      
      public function get roomItemID() : int
      {
         return var_1980;
      }
      
      public function get itemType() : String
      {
         return var_845;
      }
      
      public function get itemID() : int
      {
         return var_1775;
      }
      
      public function get itemSpecificData() : String
      {
         return var_1983;
      }
      
      public function get songID() : int
      {
         return var_1987;
      }
      
      public function get timeToExpiration() : int
      {
         return var_1979;
      }
      
      public function get creationYear() : int
      {
         return var_1986;
      }
      
      public function get creationDay() : int
      {
         return var_1985;
      }
      
      public function get category() : int
      {
         return _category;
      }
   }
}
