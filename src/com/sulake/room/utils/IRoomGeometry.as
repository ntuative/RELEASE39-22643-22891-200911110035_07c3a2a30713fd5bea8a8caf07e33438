package com.sulake.room.utils
{
   import flash.geom.Point;
   
   public interface IRoomGeometry
   {
       
      
      function get directionAxis() : IVector3d;
      
      function isZoomedIn() : Boolean;
      
      function get updateId() : int;
      
      function get scale() : Number;
      
      function getScreenPosition(param1:IVector3d) : IVector3d;
      
      function getScreenPoint(param1:IVector3d) : Point;
      
      function getPlanePosition(param1:Point, param2:IVector3d, param3:IVector3d, param4:IVector3d) : Point;
      
      function set z_scale(param1:Number) : void;
      
      function performZoom() : void;
      
      function getCoordinatePosition(param1:IVector3d) : IVector3d;
      
      function setDisplacement(param1:IVector3d, param2:IVector3d) : void;
      
      function performZoomOut() : void;
      
      function get direction() : IVector3d;
   }
}
