package com.sulake.room.renderer.cache
{
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomObjectLocationCacheItem
   {
       
      
      private var var_1769:int = -1;
      
      private var var_1770:int = -1;
      
      private var var_604:Vector3d = null;
      
      public function RoomObjectLocationCacheItem()
      {
         super();
         var_604 = new Vector3d();
      }
      
      public function get objectUpdateId() : int
      {
         return var_1769;
      }
      
      public function set objectUpdateId(param1:int) : void
      {
         var_1769 = param1;
      }
      
      public function set screenLoc(param1:IVector3d) : void
      {
         var_604.assign(param1);
         var_604.x = Math.round(var_604.x);
         var_604.y = Math.round(var_604.y);
      }
      
      public function set geometryUpdateId(param1:int) : void
      {
         var_1770 = param1;
      }
      
      public function get screenLoc() : IVector3d
      {
         return var_604;
      }
      
      public function get geometryUpdateId() : int
      {
         return var_1770;
      }
   }
}
