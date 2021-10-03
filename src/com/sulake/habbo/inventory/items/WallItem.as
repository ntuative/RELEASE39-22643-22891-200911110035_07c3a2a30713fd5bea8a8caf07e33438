package com.sulake.habbo.inventory.items
{
   public class WallItem implements IItem
   {
       
      
      protected var _id:int;
      
      protected var var_1218:String;
      
      protected var var_2033:Boolean;
      
      protected var var_2034:int;
      
      protected var _type:int;
      
      protected var _category:int;
      
      protected var var_1981:Boolean;
      
      protected var var_2031:Boolean;
      
      protected var var_2035:Boolean;
      
      public function WallItem(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:Boolean, param7:Boolean, param8:String)
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
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function set extras(param1:String) : void
      {
         var_1218 = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get locked() : Boolean
      {
         return var_2031;
      }
      
      public function get tradeable() : Boolean
      {
         return var_2035;
      }
      
      public function get ref() : int
      {
         return var_2034;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get extras() : String
      {
         return var_1218;
      }
      
      public function get recyclable() : Boolean
      {
         return var_2033;
      }
      
      public function get groupable() : Boolean
      {
         return var_1981;
      }
      
      public function set locked(param1:Boolean) : void
      {
         var_2031 = param1;
      }
   }
}
