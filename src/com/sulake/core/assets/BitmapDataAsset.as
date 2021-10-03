package com.sulake.core.assets
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class BitmapDataAsset implements IAsset
   {
      
      protected static var var_550:uint = 0;
      
      protected static var var_549:uint = 0;
       
      
      private var _disposed:Boolean = false;
      
      private var var_1018:AssetTypeDeclaration;
      
      private var var_59:BitmapData = null;
      
      private var var_816:String;
      
      private var _offset:Point;
      
      public function BitmapDataAsset(param1:AssetTypeDeclaration, param2:String = null)
      {
         _offset = new Point(0,0);
         super();
         var_1018 = param1;
         var_816 = param2;
         ++var_550;
      }
      
      public static function get allocatedByteCount() : uint
      {
         return var_549;
      }
      
      public static function get instances() : uint
      {
         return var_550;
      }
      
      public function get content() : Object
      {
         return var_59 as Object;
      }
      
      public function setFromOtherAsset(param1:IAsset) : void
      {
         if(param1 is BitmapDataAsset)
         {
            var_59 = BitmapDataAsset(param1).var_59;
            _offset = BitmapDataAsset(param1)._offset;
            return;
         }
         throw new Error("Provided asset should be of type BitmapDataAsset!");
      }
      
      public function setUnknownContent(param1:Object) : void
      {
         var _loc2_:* = null;
         if(param1 is Class)
         {
            _loc2_ = new param1() as Bitmap;
            if(_loc2_ != null)
            {
               var_59 = new BitmapData(_loc2_.bitmapData.width,_loc2_.bitmapData.height,_loc2_.bitmapData.transparent);
               var_59.copyPixels(_loc2_.bitmapData,_loc2_.bitmapData.rect,new Point(0,0),null,null,false);
               _loc2_.bitmapData.dispose();
               if(var_59 != null)
               {
                  var_549 += 0 * 0 * 4;
                  return;
               }
               throw new Error("Failed to convert Bitmap Class to BitmapDataAsset!");
            }
            var_59 = new param1() as BitmapData;
            if(var_59 != null)
            {
               return;
            }
            throw new Error("Failed to convert BitmapData Class to BitmapDataAsset!");
         }
         if(param1 is Bitmap)
         {
            var_59 = Bitmap(param1).bitmapData;
            if(var_59 == null)
            {
               throw new Error("Failed to convert Bitmap to BitmapDataAsset!");
            }
         }
         if(param1 is BitmapData)
         {
            var_59 = param1 as BitmapData;
            if(var_59 != null)
            {
               return;
            }
            throw new Error("Failed to convert BitmapData to BitmapDataAsset!");
         }
         if(param1 is BitmapDataAsset)
         {
            var_59 = BitmapDataAsset(param1).var_59;
            _offset = BitmapDataAsset(param1)._offset;
            if(var_59 != null)
            {
               return;
            }
            throw new Error("Failed to read content from BitmaDataAsset!");
         }
      }
      
      public function get offset() : Point
      {
         return _offset;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_549 -= 0 * 0 * 4;
            --var_550;
            if(var_59)
            {
               var_59.dispose();
            }
            var_59 = null;
            _offset = null;
            var_1018 = null;
            var_816 = null;
            _disposed = true;
         }
      }
      
      public function get url() : String
      {
         return var_816;
      }
      
      public function get declaration() : AssetTypeDeclaration
      {
         return var_1018;
      }
      
      public function setParamsDesc(param1:XMLList) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length())
         {
            _loc3_ = param1[_loc2_].attribute("key");
            _loc4_ = param1[_loc2_].attribute("value");
            switch(_loc3_)
            {
               case "offset":
                  _loc5_ = _loc4_.split(",");
                  _offset.x = parseInt(_loc5_[0]);
                  _offset.y = parseInt(_loc5_[1]);
                  break;
            }
            _loc2_++;
         }
      }
   }
}
