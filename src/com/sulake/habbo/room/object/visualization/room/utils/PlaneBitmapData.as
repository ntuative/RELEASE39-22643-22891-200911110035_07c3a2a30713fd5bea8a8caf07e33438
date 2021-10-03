package com.sulake.habbo.room.object.visualization.room.utils
{
   import flash.display.BitmapData;
   
   public class PlaneBitmapData
   {
       
      
      private var var_59:BitmapData = null;
      
      private var var_1354:int = 0;
      
      public function PlaneBitmapData(param1:BitmapData, param2:int)
      {
         super();
         var_59 = param1;
         var_1354 = param2;
      }
      
      public function dispose() : void
      {
         var_59 = null;
      }
      
      public function get timeStamp() : int
      {
         return var_1354;
      }
      
      public function get bitmap() : BitmapData
      {
         return var_59;
      }
   }
}
