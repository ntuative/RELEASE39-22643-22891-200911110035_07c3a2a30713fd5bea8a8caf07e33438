package com.sulake.room.object
{
   import com.sulake.room.object.logic.IRoomObjectEventHandler;
   import com.sulake.room.object.visualization.IRoomObjectVisualization;
   import com.sulake.room.utils.IVector3d;
   
   public interface IRoomObjectController extends IRoomObject
   {
       
      
      function setVisualization(param1:IRoomObjectVisualization) : void;
      
      function getEventHandler() : IRoomObjectEventHandler;
      
      function dispose() : void;
      
      function setLocation(param1:IVector3d) : void;
      
      function setEventHandler(param1:IRoomObjectEventHandler) : void;
      
      function setType(param1:String) : void;
      
      function setDirection(param1:IVector3d) : void;
      
      function getModelController() : IRoomObjectModelController;
      
      function setState(param1:int, param2:uint) : Boolean;
   }
}
