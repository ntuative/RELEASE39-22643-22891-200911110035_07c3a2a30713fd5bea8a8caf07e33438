package com.sulake.room.renderer.utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class ExtendedBitmap extends Bitmap
   {
       
      
      public function ExtendedBitmap()
      {
         super();
      }
      
      override public function set bitmapData(param1:BitmapData) : void
      {
         if(param1 == bitmapData)
         {
            return;
         }
         if(bitmapData is ExtendedBitmapData)
         {
            bitmapData.dispose();
         }
         var _loc2_:ExtendedBitmapData = param1 as ExtendedBitmapData;
         if(_loc2_ != null)
         {
            _loc2_.addReference();
         }
         super.bitmapData = param1;
      }
   }
}
