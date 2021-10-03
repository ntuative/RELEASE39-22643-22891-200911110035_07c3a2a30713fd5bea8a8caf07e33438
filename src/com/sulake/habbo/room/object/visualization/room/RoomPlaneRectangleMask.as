package com.sulake.habbo.room.object.visualization.room
{
   public class RoomPlaneRectangleMask
   {
       
      
      private var var_1506:Number = 0;
      
      private var var_1508:Number = 0;
      
      private var var_1507:Number = 0;
      
      private var var_1509:Number = 0;
      
      public function RoomPlaneRectangleMask(param1:Number, param2:Number, param3:Number, param4:Number)
      {
         super();
         var_1508 = param1;
         var_1507 = param2;
         var_1506 = param3;
         var_1509 = param4;
      }
      
      public function get leftSideLoc() : Number
      {
         return var_1508;
      }
      
      public function get leftSideLength() : Number
      {
         return var_1506;
      }
      
      public function get rightSideLoc() : Number
      {
         return var_1507;
      }
      
      public function get rightSideLength() : Number
      {
         return var_1509;
      }
   }
}
