package com.sulake.room.object.visualization
{
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public interface IRoomObjectVisualization
   {
       
      
      function initialize(param1:IRoomObjectVisualizationData) : Boolean;
      
      function get boundingRectangle() : Rectangle;
      
      function get object() : IRoomObject;
      
      function update(param1:IRoomGeometry = null) : void;
      
      function get image() : BitmapData;
      
      function set object(param1:IRoomObject) : void;
      
      function dispose() : void;
   }
}
