package com.sulake.room.renderer.utils
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class ExtendedBitmapData extends BitmapData
   {
       
      
      private var var_968:int = 0;
      
      public function ExtendedBitmapData(param1:int, param2:int, param3:Boolean = true, param4:uint = 0)
      {
         super(param1,param2,param3,param4);
      }
      
      public function addReference() : void
      {
         ++var_968;
      }
      
      override public function clone() : BitmapData
      {
         var _loc1_:ExtendedBitmapData = new ExtendedBitmapData(width,height,true,16777215);
         _loc1_.copyPixels(this,rect,new Point(0,0),null,null,true);
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         if(--var_968 <= 0)
         {
            super.dispose();
         }
      }
   }
}
