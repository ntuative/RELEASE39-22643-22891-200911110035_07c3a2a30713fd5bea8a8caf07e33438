package com.sulake.habbo.room.object
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import com.sulake.room.utils.XMLValidator;
   
   public class RoomPlaneBitmapMaskParser
   {
       
      
      private var var_146:Map = null;
      
      public function RoomPlaneBitmapMaskParser()
      {
         super();
         var_146 = new Map();
      }
      
      public function getMaskCategory(param1:int) : String
      {
         if(param1 < 0 || param1 >= maskCount)
         {
            return null;
         }
         var _loc2_:RoomPlaneBitmapMaskData = var_146.getWithIndex(param1) as RoomPlaneBitmapMaskData;
         if(_loc2_ != null)
         {
            return _loc2_.category;
         }
         return null;
      }
      
      public function getXML() : XML
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc1_:XML = <planeMasks/>;
         var _loc2_:int = 0;
         while(_loc2_ < maskCount)
         {
            _loc3_ = getMaskType(_loc2_);
            _loc4_ = getMaskCategory(_loc2_);
            _loc5_ = <planeMask id="{_loc2_}" type="{_loc3_}" category="{_loc4_}"/>;
            _loc6_ = getMaskLocation(_loc2_);
            if(_loc6_ != null)
            {
               _loc5_.appendChild(<location x="{_loc6_.x}" y="{_loc6_.y}" z="{_loc6_.z}"/>);
               _loc1_.appendChild(_loc5_);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get maskCount() : int
      {
         return var_146.length;
      }
      
      public function dispose() : void
      {
         if(var_146 != null)
         {
            reset();
            var_146.dispose();
            var_146 = null;
         }
      }
      
      public function addMask(param1:String, param2:String, param3:IVector3d, param4:String) : void
      {
         var _loc5_:RoomPlaneBitmapMaskData = new RoomPlaneBitmapMaskData(param2,param3,param4);
         var_146.remove(param1);
         var_146.add(param1,_loc5_);
      }
      
      public function reset() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         while(_loc1_ < var_146.length)
         {
            _loc2_ = var_146.getWithIndex(_loc1_) as RoomPlaneBitmapMaskData;
            if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
            _loc1_++;
         }
         var_146.reset();
      }
      
      public function initialize(param1:XML) : Boolean
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         if(param1 == null)
         {
            return false;
         }
         var_146.reset();
         var _loc2_:* = ["id","type","category"];
         var _loc3_:* = ["x","y","z"];
         var _loc5_:XMLList = param1.planeMask;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length())
         {
            _loc7_ = _loc5_[_loc6_];
            if(!XMLValidator.checkRequiredAttributes(_loc7_,_loc2_))
            {
               return false;
            }
            _loc8_ = _loc7_.@id;
            _loc9_ = _loc7_.@type;
            _loc10_ = null;
            _loc11_ = _loc7_.@category;
            _loc12_ = _loc7_.location;
            if(_loc12_.length() != 1)
            {
               return false;
            }
            _loc13_ = _loc12_[0];
            if(!XMLValidator.checkRequiredAttributes(_loc13_,_loc3_))
            {
               return false;
            }
            _loc10_ = new Vector3d(Number(_loc13_.@x),Number(_loc13_.@y),Number(_loc13_.@z));
            _loc14_ = new RoomPlaneBitmapMaskData(_loc9_,_loc10_,_loc11_);
            var_146.add(_loc8_,_loc14_);
            _loc6_++;
         }
         return true;
      }
      
      public function removeMask(param1:String) : Boolean
      {
         var _loc2_:RoomPlaneBitmapMaskData = var_146.remove(param1) as RoomPlaneBitmapMaskData;
         if(_loc2_ != null)
         {
            _loc2_.dispose();
            return true;
         }
         return false;
      }
      
      public function getMaskType(param1:int) : String
      {
         if(param1 < 0 || param1 >= maskCount)
         {
            return null;
         }
         var _loc2_:RoomPlaneBitmapMaskData = var_146.getWithIndex(param1) as RoomPlaneBitmapMaskData;
         if(_loc2_ != null)
         {
            return _loc2_.type;
         }
         return null;
      }
      
      public function getMaskLocation(param1:int) : IVector3d
      {
         if(param1 < 0 || param1 >= maskCount)
         {
            return null;
         }
         var _loc2_:RoomPlaneBitmapMaskData = var_146.getWithIndex(param1) as RoomPlaneBitmapMaskData;
         if(_loc2_ != null)
         {
            return _loc2_.loc;
         }
         return null;
      }
   }
}
