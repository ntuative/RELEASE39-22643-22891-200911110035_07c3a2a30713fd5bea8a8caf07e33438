package com.sulake.habbo.room.object.visualization.furniture.data
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.utils.XMLValidator;
   
   public class AnimationData
   {
      
      public static const const_1479:int = 0;
       
      
      private var var_1327:Boolean = false;
      
      private var var_168:Map = null;
      
      public function AnimationData()
      {
         super();
         var_168 = new Map();
      }
      
      public function initialize(param1:XML) : Boolean
      {
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Boolean = false;
         var_1327 = false;
         _loc3_ = param1.@randomStart;
         if(_loc3_.length() == 1)
         {
            if(int(_loc3_) != 0)
            {
               var_1327 = true;
            }
         }
         var _loc2_:* = ["id"];
         _loc3_ = null;
         var _loc4_:XMLList = param1.animationLayer;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length())
         {
            _loc6_ = _loc4_[_loc5_];
            if(!XMLValidator.checkRequiredAttributes(_loc6_,_loc2_))
            {
               return false;
            }
            _loc7_ = int(_loc6_.@id);
            _loc8_ = 1;
            _loc9_ = 1;
            _loc10_ = false;
            _loc3_ = _loc6_.@loopCount;
            if(_loc3_.length() == 1)
            {
               _loc8_ = int(_loc3_);
            }
            _loc3_ = _loc6_.@frameRepeat;
            if(_loc3_.length() == 1)
            {
               _loc9_ = int(_loc3_);
            }
            _loc3_ = _loc6_.@random;
            if(_loc3_.length() == 1)
            {
               if(int(_loc3_) != 0)
               {
                  _loc10_ = true;
               }
            }
            if(!addLayer(_loc7_,_loc8_,_loc9_,_loc10_,_loc6_))
            {
               return false;
            }
            _loc5_++;
         }
         return true;
      }
      
      public function getFrameFromSequence(param1:int, param2:int, param3:int, param4:int) : AnimationFrame
      {
         var _loc5_:AnimationLayerData = var_168.getValue(param1) as AnimationLayerData;
         if(_loc5_ != null)
         {
            return _loc5_.getFrameFromSequence(param2,param3,param4);
         }
         return null;
      }
      
      private function addLayer(param1:int, param2:int, param3:int, param4:Boolean, param5:XML) : Boolean
      {
         var _loc11_:* = null;
         var _loc12_:int = 0;
         var _loc13_:Boolean = false;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:int = 0;
         var _loc17_:* = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc6_:AnimationLayerData = new AnimationLayerData(param2,param3,param4);
         var _loc7_:* = ["id"];
         var _loc8_:* = null;
         var _loc9_:XMLList = param5.frameSequence;
         var _loc10_:int = 0;
         while(_loc10_ < _loc9_.length())
         {
            _loc11_ = _loc9_[_loc10_];
            _loc12_ = 1;
            _loc13_ = false;
            _loc8_ = _loc11_.@loopCount;
            if(_loc8_.length() == 1)
            {
               _loc12_ = int(_loc8_);
            }
            _loc8_ = _loc11_.@random;
            if(_loc8_.length() == 1)
            {
               if(int(_loc8_) != 0)
               {
                  _loc13_ = true;
               }
            }
            _loc14_ = _loc6_.addFrameSequence(_loc12_,_loc13_);
            _loc15_ = _loc11_.frame;
            _loc16_ = 0;
            while(_loc16_ < _loc15_.length())
            {
               _loc17_ = _loc15_[_loc16_];
               if(!XMLValidator.checkRequiredAttributes(_loc17_,_loc7_))
               {
                  _loc6_.dispose();
                  return false;
               }
               _loc18_ = int(_loc17_.@id);
               _loc19_ = 0;
               _loc20_ = 0;
               _loc21_ = 0;
               _loc22_ = 0;
               _loc8_ = _loc17_.@x;
               if(_loc8_.length() == 1)
               {
                  _loc19_ = int(_loc8_);
               }
               _loc8_ = _loc17_.@y;
               if(_loc8_.length() == 1)
               {
                  _loc20_ = int(_loc8_);
               }
               _loc8_ = _loc17_.@randomX;
               if(_loc8_.length() == 1)
               {
                  _loc21_ = int(_loc8_);
               }
               _loc8_ = _loc17_.@randomY;
               if(_loc8_.length() == 1)
               {
                  _loc22_ = int(_loc8_);
               }
               _loc14_.addFrame(_loc18_,_loc19_,_loc20_,_loc21_,_loc22_);
               _loc16_++;
            }
            _loc10_++;
         }
         _loc6_.calculateLength();
         var_168.add(param1,_loc6_);
         return true;
      }
      
      public function getFrame(param1:int, param2:int) : AnimationFrame
      {
         var _loc3_:AnimationLayerData = var_168.getValue(param1) as AnimationLayerData;
         if(_loc3_ != null)
         {
            return _loc3_.getFrame(param2);
         }
         return null;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(var_168 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_168.length)
            {
               _loc2_ = var_168.getWithIndex(_loc1_) as AnimationLayerData;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            var_168.dispose();
            var_168 = null;
         }
      }
   }
}
