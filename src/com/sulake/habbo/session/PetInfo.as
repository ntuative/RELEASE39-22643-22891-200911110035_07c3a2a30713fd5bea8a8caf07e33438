package com.sulake.habbo.session
{
   public class PetInfo implements IPetInfo
   {
       
      
      private var var_1127:int;
      
      private var var_1125:int;
      
      private var var_1124:Array;
      
      private var var_1126:int;
      
      private var _hungerType:int;
      
      private var var_1144:int;
      
      public function PetInfo()
      {
         super();
      }
      
      public function get hungerType() : int
      {
         return _hungerType;
      }
      
      public function get roomIndex() : int
      {
         return var_1144;
      }
      
      public function get moodType() : int
      {
         return var_1125;
      }
      
      public function get thirstType() : int
      {
         return var_1126;
      }
      
      public function set hungerType(param1:int) : void
      {
         _hungerType = param1;
      }
      
      public function set natureTypeArray(param1:Array) : void
      {
         var_1124 = param1;
      }
      
      public function set moodType(param1:int) : void
      {
         var_1125 = param1;
      }
      
      public function set thirstType(param1:int) : void
      {
         var_1126 = param1;
      }
      
      public function set roomIndex(param1:int) : void
      {
         var_1144 = param1;
      }
      
      public function get natureTypeArray() : Array
      {
         return var_1124;
      }
      
      public function set age(param1:int) : void
      {
         var_1127 = param1;
      }
      
      public function get age() : int
      {
         return var_1127;
      }
   }
}
