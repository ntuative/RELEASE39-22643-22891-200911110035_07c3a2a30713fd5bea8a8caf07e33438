package com.sulake.room.renderer.cache
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomObjectLocationCache
   {
       
      
      private var var_1584:String = "";
      
      private var _data:Map = null;
      
      public function RoomObjectLocationCache(param1:String)
      {
         super();
         var_1584 = param1;
         _data = new Map();
      }
      
      public function getScreenLocation(param1:IRoomObject, param2:IRoomGeometry) : IVector3d
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:Number = NaN;
         var _loc8_:* = null;
         var _loc9_:* = null;
         if(param1 == null || param2 == null)
         {
            return null;
         }
         var _loc3_:String = String(param1.getInstanceId());
         var _loc4_:RoomObjectLocationCacheItem = _data.getValue(_loc3_) as RoomObjectLocationCacheItem;
         if(_loc4_ == null)
         {
            _loc4_ = new RoomObjectLocationCacheItem();
            _loc4_.geometryUpdateId = param2.updateId - 1;
            _loc4_.objectUpdateId = param1.getUpdateID() - 1;
            _data.add(_loc3_,_loc4_);
         }
         if(_loc4_.geometryUpdateId != param2.updateId || _loc4_.objectUpdateId != param1.getUpdateID())
         {
            _loc4_.geometryUpdateId = param2.updateId;
            _loc4_.objectUpdateId = param1.getUpdateID();
            _loc5_ = param1.getLocation();
            _loc6_ = param2.getScreenPosition(_loc5_);
            if(_loc6_ == null)
            {
               return null;
            }
            _loc7_ = param1.getModel().getNumber(var_1584);
            if(isNaN(_loc7_) || _loc7_ == 0)
            {
               _loc8_ = new Vector3d(Math.round(_loc5_.x),Math.round(_loc5_.y),_loc5_.z);
               if(_loc8_.x != _loc5_.x || _loc8_.y != _loc5_.y)
               {
                  _loc9_ = param2.getScreenPosition(_loc8_);
                  if(_loc9_ != null)
                  {
                     _loc4_.screenLoc = new Vector3d(_loc6_.x,_loc6_.y,_loc9_.z);
                  }
                  else
                  {
                     _loc4_.screenLoc = _loc6_;
                  }
               }
               else
               {
                  _loc4_.screenLoc = _loc6_;
               }
            }
            else
            {
               _loc4_.screenLoc = _loc6_;
            }
         }
         return _loc4_.screenLoc;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(_data != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _data.length)
            {
               _loc2_ = _data.getWithIndex(_loc1_) as RoomObjectLocationCacheItem;
               if(_loc2_ != null)
               {
               }
               _loc1_++;
            }
            _data.dispose();
            _data = null;
         }
      }
   }
}
