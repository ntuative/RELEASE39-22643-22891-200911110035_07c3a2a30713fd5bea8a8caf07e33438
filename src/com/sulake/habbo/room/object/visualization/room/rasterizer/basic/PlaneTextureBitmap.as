package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import flash.display.BitmapData;
   
   public class PlaneTextureBitmap
   {
      
      public static const const_47:Number = -1;
      
      public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;
       
      
      private var _normalMaxX:Number = 1;
      
      private var var_1629:Number = -1;
      
      private var var_1627:Number = -1;
      
      private var var_59:BitmapData = null;
      
      private var var_1628:Number = 1;
      
      public function PlaneTextureBitmap(param1:BitmapData, param2:Number = -1, param3:Number = 1, param4:Number = -1, param5:Number = 1)
      {
         super();
         var_1627 = param2;
         _normalMaxX = param3;
         var_1629 = param4;
         var_1628 = param5;
         var_59 = param1;
      }
      
      public function get normalMaxX() : Number
      {
         return _normalMaxX;
      }
      
      public function get normalMaxY() : Number
      {
         return var_1628;
      }
      
      public function get normalMinX() : Number
      {
         return var_1627;
      }
      
      public function get bitmap() : BitmapData
      {
         return var_59;
      }
      
      public function get normalMinY() : Number
      {
         return var_1629;
      }
      
      public function dispose() : void
      {
         var_59 = null;
      }
   }
}
