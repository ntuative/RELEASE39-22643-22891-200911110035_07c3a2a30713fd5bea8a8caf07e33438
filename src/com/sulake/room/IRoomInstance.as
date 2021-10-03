package com.sulake.room
{
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.renderer.IRoomRendererBase;
   
   public interface IRoomInstance
   {
       
      
      function setRenderer(param1:IRoomRendererBase) : void;
      
      function dispose() : void;
      
      function getString(param1:String) : String;
      
      function update() : void;
      
      function setNumber(param1:String, param2:Number, param3:Boolean = false) : void;
      
      function setString(param1:String, param2:String, param3:Boolean = false) : void;
      
      function getObject(param1:int, param2:int) : IRoomObject;
      
      function createRoomObject(param1:int, param2:String, param3:int) : IRoomObject;
      
      function getObjectWithIndex(param1:int, param2:int) : IRoomObject;
      
      function getRenderer() : IRoomRendererBase;
      
      function getObjectCount(param1:int) : int;
      
      function disposeObjects(param1:int) : int;
      
      function disposeObject(param1:int, param2:int) : Boolean;
      
      function getNumber(param1:String) : Number;
   }
}
