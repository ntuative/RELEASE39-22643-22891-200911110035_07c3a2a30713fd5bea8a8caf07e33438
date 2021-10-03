package com.sulake.habbo.room
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   public interface IRoomEngine extends IUnknown
   {
       
      
      function updateObjectRoomColor(param1:int, param2:int, param3:uint, param4:int, param5:Boolean) : Boolean;
      
      function setActiveRoom(param1:int, param2:int) : void;
      
      function loadRoomResources(param1:String) : Array;
      
      function deleteRoomObject(param1:int, param2:int) : Boolean;
      
      function getRoomObjectCount(param1:int, param2:int, param3:int) : int;
      
      function get isInitialized() : Boolean;
      
      function getRoomObjectImage(param1:int, param2:int, param3:int, param4:int, param5:IVector3d, param6:int, param7:IGetImageListener) : ImageResult;
      
      function getWallItemIcon(param1:int, param2:IGetImageListener, param3:String = null) : ImageResult;
      
      function getRoomStringValue(param1:int, param2:int, param3:String) : String;
      
      function getRoomImage(param1:String, param2:String, param3:String, param4:int, param5:IGetImageListener, param6:String = null) : ImageResult;
      
      function method_7(param1:int, param2:int, param3:int, param4:String = null) : Boolean;
      
      function modifyRoomObject(param1:int, param2:int, param3:String) : Boolean;
      
      function getFurnitureIcon(param1:int, param2:IGetImageListener) : ImageResult;
      
      function selectRoomObject(param1:int, param2:int, param3:int, param4:int) : void;
      
      function getRoomNumberValue(param1:int, param2:int, param3:String) : Number;
      
      function get events() : IEventDispatcher;
      
      function cancelRoomObjectInsert() : void;
      
      function getRoomObjectBoundingRectangle(param1:int, param2:int, param3:int, param4:int, param5:int) : Rectangle;
      
      function getRoomObjectWithIndex(param1:int, param2:int, param3:int, param4:int) : IRoomObject;
      
      function getSelectedAvatarId() : int;
      
      function modifyRoomObjectData(param1:int, param2:int, param3:String) : Boolean;
      
      function get activeRoomCategory() : int;
      
      function getGenericRoomObjectImage(param1:String, param2:String, param3:IVector3d, param4:int, param5:IGetImageListener, param6:String = null) : ImageResult;
      
      function getRoomCanvasGeometry(param1:int, param2:int, param3:int) : IRoomGeometry;
      
      function isPublicRoomWorldType(param1:String) : Boolean;
      
      function getWallItemImage(param1:int, param2:IVector3d, param3:int, param4:IGetImageListener, param5:String = null) : ImageResult;
      
      function modifyRoomCanvas(param1:int, param2:int, param3:int, param4:int, param5:int) : Boolean;
      
      function createRoomCanvas(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : DisplayObject;
      
      function handleRoomCanvasMouseEvent(param1:int, param2:int, param3:int, param4:String, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean) : void;
      
      function getActiveRoomBoundingRectangle(param1:int) : Rectangle;
      
      function selectAvatar(param1:int, param2:int, param3:int, param4:Boolean) : void;
      
      function getWorldType(param1:int, param2:int) : String;
      
      function getRoomObject(param1:int, param2:int, param3:int, param4:int) : IRoomObject;
      
      function getSelectedObjectData(param1:int, param2:int) : ISelectedRoomObjectData;
      
      function get activeRoomId() : int;
      
      function getFurnitureImage(param1:int, param2:IVector3d, param3:int, param4:IGetImageListener) : ImageResult;
   }
}
