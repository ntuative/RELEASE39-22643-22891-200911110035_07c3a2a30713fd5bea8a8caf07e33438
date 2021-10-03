package com.sulake.habbo.inventory.items
{
   public class FloorItem implements IItem
   {
       
      
      protected var var_1218:String;
      
      protected var var_2033:Boolean;
      
      protected var var_1985:int;
      
      protected var _type:int;
      
      protected var var_1986:int;
      
      protected var var_2031:Boolean;
      
      protected var var_1496:int;
      
      protected var var_2035:Boolean;
      
      protected var _id:int;
      
      protected var var_2034:int;
      
      protected var var_1472:String;
      
      protected var var_1981:Boolean;
      
      protected var _category:int;
      
      protected var var_1982:int;
      
      protected var var_2040:int;
      
      public function FloorItem(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:Boolean, param7:Boolean, param8:String, param9:int, param10:int, param11:int, param12:int, param13:String, param14:int)
      {
         super();
         _id = param1;
         _type = param2;
         var_2034 = param3;
         _category = param4;
         var_1981 = param5;
         var_2035 = param6;
         var_2033 = param7;
         var_1218 = param8;
         var_2040 = param9;
         var_1985 = param10;
         var_1982 = param11;
         var_1986 = param12;
         var_1472 = param13;
         var_1496 = param14;
      }
      
      public function get locked() : Boolean
      {
         return var_2031;
      }
      
      public function get songId() : int
      {
         return var_1496;
      }
      
      public function set locked(param1:Boolean) : void
      {
         var_2031 = param1;
      }
      
      public function get ref() : int
      {
         return var_2034;
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get slotId() : String
      {
         return var_1472;
      }
      
      public function get expires() : int
      {
         return var_2040;
      }
      
      public function get creationYear() : int
      {
         return var_1986;
      }
      
      public function get creationDay() : int
      {
         return var_1985;
      }
      
      public function get tradeable() : Boolean
      {
         return var_2035;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get groupable() : Boolean
      {
         return var_1981;
      }
      
      public function get creationMonth() : int
      {
         return var_1982;
      }
      
      public function get extras() : String
      {
         return var_1218;
      }
      
      public function get recyclable() : Boolean
      {
         return var_2033;
      }
   }
}
