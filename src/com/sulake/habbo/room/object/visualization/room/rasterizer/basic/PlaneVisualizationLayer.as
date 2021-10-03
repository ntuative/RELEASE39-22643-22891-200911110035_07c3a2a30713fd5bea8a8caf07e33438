package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.room.utils.IVector3d;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   
   public class PlaneVisualizationLayer implements IDisposable
   {
      
      public static const const_739:int = 0;
      
      public static const const_187:int = 2;
      
      public static const const_91:int = 1;
      
      public static const const_238:int = const_91;
       
      
      private var _material:PlaneMaterial = null;
      
      private var _color:uint = 0;
      
      private var var_1374:int = 1;
      
      private var _isDisposed:Boolean = false;
      
      private var _offset:int = 0;
      
      private var _bitmapData:BitmapData = null;
      
      public function PlaneVisualizationLayer(param1:PlaneMaterial, param2:uint, param3:int, param4:int = 0)
      {
         super();
         _material = param1;
         _offset = param4;
         var_1374 = param3;
         _color = param2;
      }
      
      public function get align() : int
      {
         return var_1374;
      }
      
      public function get disposed() : Boolean
      {
         return _isDisposed;
      }
      
      public function render(param1:BitmapData, param2:int, param3:int, param4:IVector3d, param5:Boolean) : BitmapData
      {
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:* = null;
         var _loc6_:uint = _color >> 16;
         var _loc7_:uint = _color >> 8 & 255;
         var _loc8_:uint = _color & 255;
         var _loc9_:Boolean = false;
         if(_loc6_ < 255 || _loc7_ < 255 || _loc8_ < 255)
         {
            _loc9_ = true;
         }
         if(param1 == null || param1.width != param2 || param1.height != param3)
         {
            param1 = null;
         }
         var _loc10_:* = null;
         if(_material != null)
         {
            if(_loc9_)
            {
               _loc10_ = _material.render(null,param2,param3,param4,param5,offset,align == const_91);
            }
            else
            {
               _loc10_ = _material.render(param1,param2,param3,param4,param5,offset,align == const_91);
            }
            if(_loc10_ != null && _loc10_ != param1)
            {
               if(_bitmapData != null)
               {
                  _bitmapData.dispose();
               }
               _bitmapData = _loc10_.clone();
               _loc10_ = _bitmapData;
            }
         }
         else if(param1 == null)
         {
            if(_bitmapData != null && _bitmapData.width == param2 && _bitmapData.height == param3)
            {
               return _bitmapData;
            }
            if(_bitmapData != null)
            {
               _bitmapData.dispose();
            }
            _bitmapData = new BitmapData(param2,param3,true,4294967295);
            _loc10_ = _bitmapData;
         }
         else
         {
            param1.fillRect(param1.rect,4294967295);
            _loc10_ = param1;
         }
         if(_loc10_ != null)
         {
            if(_loc9_)
            {
               _loc11_ = _loc6_ / 255;
               _loc12_ = _loc7_ / 255;
               _loc13_ = _loc8_ / 255;
               _loc14_ = new ColorTransform(_loc11_,_loc12_,_loc13_);
               _loc10_.colorTransform(_loc10_.rect,_loc14_);
               if(param1 != null && _loc10_ != param1)
               {
                  param1.copyPixels(_loc10_,_loc10_.rect,new Point(0,0),null,null,true);
                  _loc10_ = param1;
               }
            }
         }
         return _loc10_;
      }
      
      public function get offset() : int
      {
         return _offset;
      }
      
      public function dispose() : void
      {
         _isDisposed = true;
         _material = null;
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
      }
   }
}
