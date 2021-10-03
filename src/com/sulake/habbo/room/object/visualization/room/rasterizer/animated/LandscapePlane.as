package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.Plane;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneVisualization;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class LandscapePlane extends Plane
   {
      
      public static const const_164:Number = 45;
      
      public static const const_61:uint = 16777215;
      
      public static const const_148:Number = 30;
       
      
      private var _height:int = 0;
      
      private var _width:int = 0;
      
      public function LandscapePlane()
      {
         super();
      }
      
      public function render(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:IVector3d, param6:Boolean, param7:Number, param8:Number, param9:Number, param10:Number, param11:int) : BitmapData
      {
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:* = null;
         var _loc12_:PlaneVisualization = getPlaneVisualization(param4);
         if(_loc12_ == null || _loc12_.geometry == null)
         {
            return null;
         }
         var _loc13_:Point = _loc12_.geometry.getScreenPoint(new Vector3d(0,0,0));
         var _loc14_:Point = _loc12_.geometry.getScreenPoint(new Vector3d(0,0,1));
         var _loc15_:Point = _loc12_.geometry.getScreenPoint(new Vector3d(0,1,0));
         if(_loc13_ != null && _loc14_ != null && _loc15_ != null)
         {
            param2 = Math.round(Math.abs((_loc13_.x - _loc15_.x) * param2 / _loc12_.geometry.scale));
            param3 = Math.round(Math.abs((_loc13_.y - _loc14_.y) * param3 / _loc12_.geometry.scale));
            _loc16_ = param7 * Math.abs(_loc13_.x - _loc15_.x);
            _loc17_ = param8 * Math.abs(_loc13_.y - _loc14_.y);
            _loc18_ = param9 * Math.abs(_loc13_.x - _loc15_.x);
            _loc19_ = param10 * Math.abs(_loc13_.y - _loc14_.y);
            return _loc12_.render(param1,param2,param3,param5,param6,_loc16_,_loc17_,_loc18_,_loc19_,param9,param10,param11);
         }
         return null;
      }
      
      override public function isStatic(param1:int) : Boolean
      {
         var _loc2_:PlaneVisualization = getPlaneVisualization(param1);
         if(_loc2_ != null)
         {
            return !_loc2_.hasAnimationLayers;
         }
         return super.isStatic(param1);
      }
      
      public function initializeDimensions(param1:int, param2:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         if(param1 != _width || param2 != _height)
         {
            _width = param1;
            _height = param2;
         }
      }
   }
}
