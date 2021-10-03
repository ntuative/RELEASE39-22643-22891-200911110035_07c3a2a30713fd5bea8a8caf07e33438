package com.sulake.habbo.room
{
   import com.sulake.habbo.room.messages.RoomObjectUpdateStateMessage;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IVector3d;
   
   public interface IRoomObjectCreator
   {
       
      
      function updateObjectRoomColor(param1:int, param2:int, param3:uint, param4:int, param5:Boolean) : Boolean;
      
      function addObjectFurnitureByName(param1:int, param2:int, param3:int, param4:String, param5:IVector3d, param6:IVector3d, param7:int, param8:String) : Boolean;
      
      function updateObjectWallItem(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:int, param7:String) : Boolean;
      
      function disposeObjectUser(param1:int, param2:int, param3:int) : void;
      
      function updateObjectFurniture(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:int, param7:String) : Boolean;
      
      function addObjectUser(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:Number, param7:String) : Boolean;
      
      function setRoomObjectAlias(param1:String, param2:String) : void;
      
      function updateObjectWallItemData(param1:int, param2:int, param3:int, param4:String) : Boolean;
      
      function updateObjectRoom(param1:int, param2:int, param3:String = null, param4:String = null, param5:String = null) : Boolean;
      
      function addObjectFurniture(param1:int, param2:int, param3:int, param4:int, param5:IVector3d, param6:IVector3d, param7:int, param8:String) : Boolean;
      
      function updateObjectUser(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:IVector3d = null, param7:Number = NaN) : Boolean;
      
      function disposeObjectFurniture(param1:int, param2:int, param3:int) : void;
      
      function disposeObjectWallItem(param1:int, param2:int, param3:int) : void;
      
      function addObjectWallItem(param1:int, param2:int, param3:int, param4:int, param5:IVector3d, param6:IVector3d, param7:int, param8:String) : Boolean;
      
      function updateObjectUserState(param1:int, param2:int, param3:int, param4:RoomObjectUpdateStateMessage) : Boolean;
      
      function updateObjectFurnitureLocation(param1:int, param2:int, param3:int, param4:RoomObjectUpdateMessage) : Boolean;
   }
}
