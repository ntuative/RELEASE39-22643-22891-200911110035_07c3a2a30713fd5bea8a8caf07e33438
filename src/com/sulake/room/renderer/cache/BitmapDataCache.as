package com.sulake.room.renderer.cache
{
   import com.sulake.core.utils.Map;
   import flash.display.BitmapData;
   
   public class BitmapDataCache
   {
       
      
      private var var_1952:int = 0;
      
      private var var_455:int = 0;
      
      private var var_330:Array;
      
      private var var_329:Map;
      
      public function BitmapDataCache(param1:uint)
      {
         super();
         var_329 = new Map();
         var_330 = [];
         var_1952 = param1;
      }
      
      public function addBitmapData(param1:String, param2:BitmapData) : void
      {
         var _loc4_:* = null;
         if(param2 == null)
         {
            return;
         }
         var _loc3_:BitmapDataCacheItem = var_329.getValue(param1) as BitmapDataCacheItem;
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.bitmapData;
            if(_loc4_ != null)
            {
               var_455 -= _loc4_.width * _loc4_.height * 4;
            }
            _loc3_.bitmapData = param2;
         }
         else
         {
            _loc3_ = new BitmapDataCacheItem(param2,param1);
            var_329.add(param1,_loc3_);
            var_330.push(_loc3_);
         }
         var_455 += param2.width * param2.height * 4;
      }
      
      public function compress() : void
      {
         var_330.sortOn("useCount",0 | 0);
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(memUsage > memLimit)
         {
            _loc2_ = -1;
            while(_loc2_ >= 0)
            {
               _loc1_ = var_330[_loc2_] as BitmapDataCacheItem;
               if(_loc1_.useCount == 0)
               {
                  var_330.splice(_loc2_,1);
                  removeItem(_loc1_);
               }
               _loc2_--;
            }
         }
         while(memUsage > memLimit)
         {
            _loc1_ = var_330.pop() as BitmapDataCacheItem;
            if(_loc1_ == null)
            {
               break;
            }
            removeItem(_loc1_);
         }
         _loc2_ = 0;
         while(_loc2_ < var_330.length)
         {
            _loc1_ = var_330[_loc2_] as BitmapDataCacheItem;
            if(_loc1_ != null)
            {
               _loc1_.resetCount();
            }
            _loc2_++;
         }
      }
      
      public function get memUsage() : int
      {
         return var_455;
      }
      
      public function get memLimit() : int
      {
         return var_1952;
      }
      
      public function getBitmapData(param1:String) : BitmapData
      {
         var _loc2_:BitmapDataCacheItem = var_329.getValue(param1) as BitmapDataCacheItem;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.bitmapData;
      }
      
      private function removeItem(param1:BitmapDataCacheItem) : void
      {
         var _loc2_:* = null;
         if(param1 == null)
         {
            return;
         }
         param1 = var_329.remove(param1.name) as BitmapDataCacheItem;
         if(param1 != null)
         {
            _loc2_ = param1.bitmapData;
            if(_loc2_ != null)
            {
               var_455 -= _loc2_.width * _loc2_.height * 4;
            }
            param1.dispose();
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(var_329 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_329.length)
            {
               _loc2_ = var_329.getWithIndex(_loc1_) as BitmapDataCacheItem;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            var_329.dispose();
            var_329 = null;
         }
         var_330 = null;
      }
   }
}
