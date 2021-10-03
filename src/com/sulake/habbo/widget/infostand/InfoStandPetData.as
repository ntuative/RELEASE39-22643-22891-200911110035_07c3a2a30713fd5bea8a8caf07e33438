package com.sulake.habbo.widget.infostand
{
   import com.sulake.habbo.widget.events.RoomWidgetPetInfoUpdateEvent;
   
   public class InfoStandPetData
   {
       
      
      private var var_1127:int = 0;
      
      private var var_1124:Array;
      
      private var _name:String = "";
      
      private var _hungerType:int;
      
      private var var_1125:int;
      
      private var var_1126:int;
      
      public function InfoStandPetData()
      {
         super();
      }
      
      public function set age(param1:int) : void
      {
         var_1127 = param1;
      }
      
      public function set thirstType(param1:int) : void
      {
         var_1126 = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get hungerType() : int
      {
         return _hungerType;
      }
      
      public function get moodType() : int
      {
         return var_1125;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get thirstType() : int
      {
         return var_1126;
      }
      
      public function set hungerType(param1:int) : void
      {
         _hungerType = param1;
      }
      
      public function set moodType(param1:int) : void
      {
         var_1125 = param1;
      }
      
      public function get natureTypeArray() : Array
      {
         return var_1124;
      }
      
      public function set natureTypeArray(param1:Array) : void
      {
         var_1124 = param1;
      }
      
      public function setData(param1:RoomWidgetPetInfoUpdateEvent) : void
      {
         var_1127 = param1.age;
         _hungerType = param1.hungerType;
         var_1126 = param1.thirstType;
         var_1125 = param1.moodType;
         var_1124 = param1.natureTypeArray;
         _name = param1.name;
      }
      
      public function get age() : int
      {
         return var_1127;
      }
   }
}
