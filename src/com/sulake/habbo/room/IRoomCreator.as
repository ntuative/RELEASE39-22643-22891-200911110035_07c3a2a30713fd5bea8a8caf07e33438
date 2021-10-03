package com.sulake.habbo.room
{
   import com.sulake.habbo.room.utils.LegacyWallGeometry;
   import com.sulake.habbo.room.utils.TileHeightMap;
   import com.sulake.room.IRoomInstance;
   import com.sulake.room.object.IRoomObjectController;
   
   public interface IRoomCreator extends IRoomObjectCreator
   {
       
      
      function getTileHeightMap(param1:int, param2:int) : TileHeightMap;
      
      function setTileHeightMap(param1:int, param2:int, param3:TileHeightMap) : void;
      
      function setWorldType(param1:int, param2:int, param3:String) : void;
      
      function initializeRoom(param1:int, param2:int, param3:XML) : void;
      
      function isPublicRoom(param1:int, param2:int) : Boolean;
      
      function getRoomStringValue(param1:int, param2:int, param3:String) : String;
      
      function getObjectRoom(param1:int, param2:int) : IRoomObjectController;
      
      function getRoom(param1:int, param2:int) : IRoomInstance;
      
      function getRoomNumberValue(param1:int, param2:int, param3:String) : Number;
      
      function getLegacyGeometry(param1:int, param2:int) : LegacyWallGeometry;
      
      function setOwnUserId(param1:int, param2:int, param3:int) : void;
      
      function disposeRoom(param1:int, param2:int) : void;
   }
}
