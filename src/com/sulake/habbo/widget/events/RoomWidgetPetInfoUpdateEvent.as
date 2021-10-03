package com.sulake.habbo.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetPetInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_125:String = "RWPIUE_PET_INFO";
       
      
      private var var_1127:int;
      
      private var var_1124:Array;
      
      private var _image:BitmapData;
      
      private var var_1945:int;
      
      private var _name:String;
      
      private var _hungerType:int;
      
      private var var_1125:int;
      
      private var var_1126:int;
      
      private var var_1944:int;
      
      public function RoomWidgetPetInfoUpdateEvent(param1:int, param2:int, param3:int, param4:int, param5:Array, param6:int, param7:int, param8:String, param9:BitmapData, param10:Boolean = false, param11:Boolean = false)
      {
         super(RoomWidgetPetInfoUpdateEvent.const_125,param10,param11);
         var_1127 = param1;
         _hungerType = param2;
         var_1126 = param3;
         var_1125 = param4;
         var_1124 = param5;
         var_1944 = param6;
         var_1945 = param7;
         _name = param8;
         _image = param9;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get hungerType() : int
      {
         return _hungerType;
      }
      
      public function get petRace() : int
      {
         return var_1945;
      }
      
      public function get moodType() : int
      {
         return var_1125;
      }
      
      public function get thirstType() : int
      {
         return var_1126;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
      
      public function get natureTypeArray() : Array
      {
         return var_1124;
      }
      
      public function get petType() : int
      {
         return var_1944;
      }
      
      public function get age() : int
      {
         return var_1127;
      }
   }
}
