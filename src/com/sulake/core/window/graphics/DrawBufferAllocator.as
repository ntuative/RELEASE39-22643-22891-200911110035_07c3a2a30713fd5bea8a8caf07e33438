package com.sulake.core.window.graphics
{
   import com.sulake.core.runtime.IDisposable;
   import flash.display.BitmapData;
   
   public class DrawBufferAllocator implements IDisposable
   {
      
      private static const const_1041:uint = 16777215;
       
      
      private var var_519:Array;
      
      private var _disposed:Boolean;
      
      public function DrawBufferAllocator()
      {
         super();
         _disposed = false;
         var_519 = new Array();
      }
      
      public function get allocatedByteCount() : uint
      {
         var bitmap:BitmapData = null;
         var bytes:uint = 0;
         var index:uint = 0;
         while(index > 0)
         {
            index--;
            bitmap = BitmapData(var_519[index]);
            try
            {
               bytes += bitmap.width * bitmap.height * 4;
            }
            catch(e:Error)
            {
               Logger.log("Disposed bitmap in DrawBufferAllocator!");
            }
         }
         return bytes;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(!_disposed)
         {
            _disposed = true;
            _loc1_ = 0;
            while(_loc1_ > 0)
            {
               BitmapData(var_519.pop()).dispose();
               _loc1_--;
            }
         }
      }
      
      public function free(param1:BitmapData) : void
      {
         var _loc2_:uint = var_519.indexOf(param1);
         if(_loc2_ < 0)
         {
            throw new ArgumentError("Provided bitmap data is not managed by this instance!");
         }
         var_519.splice(_loc2_,1);
         param1.dispose();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function allocate(param1:int, param2:int, param3:Boolean = true, param4:uint = 4.294967295E9) : BitmapData
      {
         var bitmap:BitmapData = null;
         var width:int = param1;
         var height:int = param2;
         var transparent:Boolean = param3;
         var fillColor:uint = param4;
         if(width < 1 || height < 1 || width * height > const_1041)
         {
            throw new ArgumentError("Given bitmap size is invalid: " + width + " x " + height + "!");
         }
         try
         {
            bitmap = new BitmapData(width,height,transparent,fillColor);
         }
         catch(error:ArgumentError)
         {
            Logger.log("Failed to allocate draw buffer!");
            bitmap = new BitmapData(1,1,transparent,fillColor);
         }
         var_519.push(bitmap);
         return bitmap;
      }
   }
}
