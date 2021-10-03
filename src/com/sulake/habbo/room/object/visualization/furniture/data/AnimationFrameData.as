package com.sulake.habbo.room.object.visualization.furniture.data
{
   public class AnimationFrameData
   {
       
      
      private var _id:int = 0;
      
      private var var_1873:int = 0;
      
      private var var_1874:int = 0;
      
      private var var_88:int = 0;
      
      private var _y:int = 0;
      
      public function AnimationFrameData(param1:int, param2:int, param3:int, param4:int, param5:int)
      {
         super();
         _id = param1;
         var_88 = param2;
         _y = param3;
         var_1873 = param4;
         var_1874 = param5;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function get randomX() : int
      {
         return var_1873;
      }
      
      public function get x() : int
      {
         return var_88;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get randomY() : int
      {
         return var_1874;
      }
   }
}
