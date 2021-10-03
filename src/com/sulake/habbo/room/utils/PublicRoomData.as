package com.sulake.habbo.room.utils
{
   import com.sulake.core.utils.Map;
   
   public class PublicRoomData
   {
       
      
      private var _worlds:Map = null;
      
      private var _type:String = "";
      
      public function PublicRoomData(param1:String)
      {
         super();
         _type = param1;
         _worlds = new Map();
      }
      
      public function addWorld(param1:String, param2:Number, param3:Number) : Boolean
      {
         if(_worlds.getValue(param1) != null)
         {
            return false;
         }
         var _loc4_:PublicRoomWorldData = new PublicRoomWorldData(param1,param2,param3);
         _worlds.add(param1,_loc4_);
         return true;
      }
      
      public function hasWorldType(param1:String) : Boolean
      {
         if(_worlds.getValue(param1) != null)
         {
            return true;
         }
         return false;
      }
      
      public function getWorldHeightScale(param1:String) : Number
      {
         var _loc2_:PublicRoomWorldData = _worlds.getValue(param1) as PublicRoomWorldData;
         if(_loc2_ != null)
         {
            return _loc2_.heightScale;
         }
         return 1;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function getWorldScale(param1:String) : Number
      {
         var _loc2_:PublicRoomWorldData = _worlds.getValue(param1) as PublicRoomWorldData;
         if(_loc2_ != null)
         {
            return _loc2_.scale;
         }
         return 1;
      }
   }
}
