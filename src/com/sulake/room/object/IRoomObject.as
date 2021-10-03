package com.sulake.room.object
{
   import com.sulake.room.object.logic.IRoomObjectMouseHandler;
   import com.sulake.room.object.visualization.IRoomObjectVisualization;
   import com.sulake.room.utils.IVector3d;
   
   public interface IRoomObject
   {
       
      
      function getType() : String;
      
      function getId() : int;
      
      function getMouseHandler() : IRoomObjectMouseHandler;
      
      function getModel() : IRoomObjectModel;
      
      function getInstanceId() : int;
      
      function getDirection() : IVector3d;
      
      function getState(param1:uint) : int;
      
      function getLocation() : IVector3d;
      
      function getUpdateID() : uint;
      
      function getVisualization() : IRoomObjectVisualization;
   }
}
