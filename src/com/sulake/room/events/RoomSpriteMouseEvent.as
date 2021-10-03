package com.sulake.room.events
{
   public class RoomSpriteMouseEvent
   {
       
      
      private var var_1476:Boolean = false;
      
      private var var_1477:Boolean = false;
      
      private var var_1675:String = "";
      
      private var _type:String = "";
      
      private var var_1479:Boolean = false;
      
      private var var_1919:Number = 0;
      
      private var var_2008:Number = 0;
      
      private var var_2007:Number = 0;
      
      private var var_2006:String = "";
      
      private var var_1920:Number = 0;
      
      private var var_1478:Boolean = false;
      
      public function RoomSpriteMouseEvent(param1:String, param2:String, param3:String, param4:Number, param5:Number, param6:Number = 0, param7:Number = 0, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false)
      {
         super();
         _type = param1;
         var_2006 = param2;
         var_1675 = param3;
         var_2008 = param4;
         var_2007 = param5;
         var_1919 = param6;
         var_1920 = param7;
         var_1478 = param8;
         var_1477 = param9;
         var_1479 = param10;
         var_1476 = param11;
      }
      
      public function get ctrlKey() : Boolean
      {
         return var_1478;
      }
      
      public function get buttonDown() : Boolean
      {
         return var_1476;
      }
      
      public function get localX() : Number
      {
         return var_1919;
      }
      
      public function get localY() : Number
      {
         return var_1920;
      }
      
      public function get canvasId() : String
      {
         return var_2006;
      }
      
      public function get altKey() : Boolean
      {
         return var_1477;
      }
      
      public function get spriteTag() : String
      {
         return var_1675;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get screenX() : Number
      {
         return var_2008;
      }
      
      public function get screenY() : Number
      {
         return var_2007;
      }
      
      public function get shiftKey() : Boolean
      {
         return var_1479;
      }
   }
}
