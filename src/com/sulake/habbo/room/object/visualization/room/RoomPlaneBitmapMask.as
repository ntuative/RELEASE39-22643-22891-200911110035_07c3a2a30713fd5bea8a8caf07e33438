package com.sulake.habbo.room.object.visualization.room
{
   public class RoomPlaneBitmapMask
   {
       
      
      private var var_1508:Number = 0;
      
      private var _type:String = null;
      
      private var var_1507:Number = 0;
      
      public function RoomPlaneBitmapMask(param1:String, param2:Number, param3:Number)
      {
         super();
         _type = param1;
         var_1508 = param2;
         var_1507 = param3;
      }
      
      public function get leftSideLoc() : Number
      {
         return var_1508;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get rightSideLoc() : Number
      {
         return var_1507;
      }
   }
}
