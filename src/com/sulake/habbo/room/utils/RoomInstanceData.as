package com.sulake.habbo.room.utils
{
   public class RoomInstanceData
   {
       
      
      private var var_770:LegacyWallGeometry = null;
      
      private var var_512:SelectedRoomObjectData = null;
      
      private var _roomCategory:int = 0;
      
      private var var_511:TileHeightMap = null;
      
      private var var_1869:String = null;
      
      private var _roomId:int = 0;
      
      private var var_769:RoomCamera = null;
      
      public function RoomInstanceData(param1:int, param2:int)
      {
         super();
         _roomId = param1;
         _roomCategory = param2;
         var_770 = new LegacyWallGeometry();
         var_769 = new RoomCamera();
      }
      
      public function set tileHeightMap(param1:TileHeightMap) : void
      {
         if(var_511 != null)
         {
            var_511.dispose();
         }
         var_511 = param1;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function set worldType(param1:String) : void
      {
         var_1869 = param1;
      }
      
      public function get legacyGeometry() : LegacyWallGeometry
      {
         return var_770;
      }
      
      public function get roomCamera() : RoomCamera
      {
         return var_769;
      }
      
      public function dispose() : void
      {
         if(var_511 != null)
         {
            var_511.dispose();
            var_511 = null;
         }
         if(var_770 != null)
         {
            var_770.dispose();
            var_770 = null;
         }
         if(var_769 != null)
         {
            var_769.dispose();
            var_769 = null;
         }
         if(var_512 != null)
         {
            var_512.dispose();
            var_512 = null;
         }
      }
      
      public function get tileHeightMap() : TileHeightMap
      {
         return var_511;
      }
      
      public function get worldType() : String
      {
         return var_1869;
      }
      
      public function set selectedObject(param1:SelectedRoomObjectData) : void
      {
         if(var_512 != null)
         {
            var_512.dispose();
         }
         var_512 = param1;
      }
      
      public function get roomCategory() : int
      {
         return _roomCategory;
      }
      
      public function get selectedObject() : SelectedRoomObjectData
      {
         return var_512;
      }
   }
}
