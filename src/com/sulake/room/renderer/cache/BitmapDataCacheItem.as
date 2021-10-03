package com.sulake.room.renderer.cache
{
   import com.sulake.room.renderer.utils.ExtendedBitmapData;
   import flash.display.BitmapData;
   
   public class BitmapDataCacheItem
   {
       
      
      private var var_447:int = 0;
      
      private var _name:String = "";
      
      private var _bitmapData:BitmapData = null;
      
      public function BitmapDataCacheItem(param1:BitmapData, param2:String)
      {
         super();
         _bitmapData = param1;
         _name = param2;
         var _loc3_:ExtendedBitmapData = _bitmapData as ExtendedBitmapData;
         if(_loc3_ != null)
         {
            _loc3_.addReference();
         }
         var_447 = 1;
      }
      
      public function resetCount() : void
      {
         var_447 = 0;
      }
      
      public function get useCount() : int
      {
         return var_447;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set bitmapData(param1:BitmapData) : void
      {
         var _loc2_:ExtendedBitmapData = _bitmapData as ExtendedBitmapData;
         if(_loc2_ != null)
         {
            _loc2_.dispose();
         }
         _bitmapData = param1;
         var_447 = 1;
         _loc2_ = _bitmapData as ExtendedBitmapData;
         if(_loc2_ != null)
         {
            _loc2_.addReference();
         }
      }
      
      public function get bitmapData() : BitmapData
      {
         ++var_447;
         return _bitmapData;
      }
      
      public function dispose() : void
      {
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
      }
   }
}
