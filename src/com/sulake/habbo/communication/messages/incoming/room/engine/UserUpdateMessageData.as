package com.sulake.habbo.communication.messages.incoming.room.engine
{
   public class UserUpdateMessageData
   {
       
      
      private var _y:Number = 0;
      
      private var var_87:Number = 0;
      
      private var var_207:int = 0;
      
      private var var_1449:int = 0;
      
      private var var_1452:Number = 0;
      
      private var var_1453:Number = 0;
      
      private var var_1450:Number = 0;
      
      private var var_1454:Number = 0;
      
      private var var_1451:Boolean = false;
      
      private var var_88:Number = 0;
      
      private var _id:int = 0;
      
      private var var_231:Array;
      
      public function UserUpdateMessageData(param1:int, param2:Number, param3:Number, param4:Number, param5:Number, param6:int, param7:int, param8:Number, param9:Number, param10:Number, param11:Boolean, param12:Array)
      {
         var_231 = [];
         super();
         _id = param1;
         var_88 = param2;
         _y = param3;
         var_87 = param4;
         var_1454 = param5;
         var_207 = param6;
         var_1449 = param7;
         var_1452 = param8;
         var_1453 = param9;
         var_1450 = param10;
         var_1451 = param11;
         var_231 = param12;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function get z() : Number
      {
         return var_87;
      }
      
      public function get dir() : int
      {
         return var_207;
      }
      
      public function get localZ() : Number
      {
         return var_1454;
      }
      
      public function get isMoving() : Boolean
      {
         return var_1451;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get dirHead() : int
      {
         return var_1449;
      }
      
      public function get targetX() : Number
      {
         return var_1452;
      }
      
      public function get targetY() : Number
      {
         return var_1453;
      }
      
      public function get targetZ() : Number
      {
         return var_1450;
      }
      
      public function get x() : Number
      {
         return var_88;
      }
      
      public function get actions() : Array
      {
         return var_231.slice();
      }
   }
}
