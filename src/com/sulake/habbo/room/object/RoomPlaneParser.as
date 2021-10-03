package com.sulake.habbo.room.object
{
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import com.sulake.room.utils.XMLValidator;
   import flash.geom.Point;
   
   public class RoomPlaneParser
   {
      
      public static const TILE_BLOCKED:int = -10;
       
      
      private var var_104:Array;
      
      private var var_565:Number = 0;
      
      private var var_322:int = 0;
      
      private var var_320:int = 0;
      
      private var var_1131:Number = 0;
      
      private var var_105:Array;
      
      private var _height:int = 0;
      
      private var _width:int = 0;
      
      private var var_761:Number = 0;
      
      private var var_321:int = 0;
      
      private var var_323:int = 0;
      
      private var var_114:Number = 0;
      
      public function RoomPlaneParser()
      {
         var_104 = [];
         var_105 = [];
         super();
         var_1131 = 3.6;
         var_761 = 0.25;
         var_114 = 0.25;
      }
      
      private static function findEntranceTile(param1:Array) : Point
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:int = param1.length;
         if(_loc5_ == 0)
         {
            return null;
         }
         var _loc6_:* = [];
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc4_ = param1[_loc3_] as Array;
            if(_loc4_ == null || _loc4_.length == 0)
            {
               return null;
            }
            _loc2_ = 0;
            while(_loc2_ < _loc4_.length)
            {
               if(Number(_loc4_[_loc2_]) >= 0)
               {
                  _loc6_.push(_loc2_);
                  break;
               }
               _loc2_++;
            }
            if(_loc6_.length < _loc3_ + 1)
            {
               _loc6_.push(_loc4_.length + 1);
            }
            _loc3_++;
         }
         _loc3_ = 1;
         while(_loc3_ < _loc6_.length - 1)
         {
            if(int(_loc6_[_loc3_]) <= int(_loc6_[_loc3_ - 1]) - 1 && int(_loc6_[_loc3_]) <= int(_loc6_[_loc3_ + 1]) - 1)
            {
               return new Point(int(_loc6_[_loc3_]),_loc3_);
            }
            _loc3_++;
         }
         return null;
      }
      
      private static function getFloorHeight(param1:Array) : Number
      {
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:int = param1.length;
         if(_loc5_ == 0)
         {
            return 0;
         }
         var _loc7_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc4_ = param1[_loc3_] as Array;
            _loc2_ = 0;
            while(_loc2_ < _loc4_.length)
            {
               _loc8_ = Number(_loc4_[_loc2_]);
               if(_loc8_ > _loc7_)
               {
                  _loc7_ = Number(_loc8_);
               }
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc7_;
      }
      
      public function getPlaneType(param1:int) : int
      {
         if(param1 < 0 || param1 >= planeCount)
         {
            return RoomPlaneData.const_740;
         }
         var _loc2_:RoomPlaneData = var_105[param1] as RoomPlaneData;
         if(_loc2_ != null)
         {
            return _loc2_.type;
         }
         return RoomPlaneData.const_740;
      }
      
      private function extractRightWall(param1:Point) : Point
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:int = 1;
         while(_loc2_ < 1000)
         {
            if(getTileHeightInternal(param1.x,param1.y + _loc2_) != TILE_BLOCKED)
            {
               return new Point(param1.x,param1.y + (_loc2_ - 1));
            }
            if(getTileHeightInternal(param1.x - 1,param1.y + _loc2_) == TILE_BLOCKED)
            {
               return new Point(param1.x - 1,param1.y + _loc2_);
            }
            _loc2_++;
         }
         return null;
      }
      
      private function addWall(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:IVector3d, param5:Boolean, param6:Boolean, param7:Boolean) : void
      {
         var _loc11_:* = null;
         addPlane(RoomPlaneData.const_142,param1,param2,param3,[param4]);
         addPlane(RoomPlaneData.const_255,param1,param2,param3,[param4]);
         var _loc9_:Vector3d = Vector3d.crossProduct(param2,param3);
         var _loc10_:Vector3d = Vector3d.product(_loc9_,1 / _loc9_.length * -var_761);
         addPlane(RoomPlaneData.const_142,Vector3d.sum(param1,param3),param2,_loc10_,[_loc9_,param4]);
         if(param5)
         {
            addPlane(RoomPlaneData.const_142,Vector3d.sum(Vector3d.sum(param1,param2),param3),Vector3d.product(param3,-(param3.length + var_114) / param3.length),_loc10_,[_loc9_,param4]);
         }
         if(param6)
         {
            addPlane(RoomPlaneData.const_142,Vector3d.sum(param1,Vector3d.product(param3,-var_114 / param3.length)),Vector3d.product(param3,(param3.length + var_114) / param3.length),_loc10_,[_loc9_,param4]);
            if(param7)
            {
               _loc11_ = Vector3d.product(param2,var_761 / param2.length);
               addPlane(RoomPlaneData.const_142,Vector3d.sum(Vector3d.sum(param1,param3),Vector3d.product(_loc11_,-1)),_loc11_,_loc10_,[_loc9_,param2,param4]);
            }
         }
      }
      
      public function getPlaneRightSide(param1:int) : IVector3d
      {
         if(param1 < 0 || param1 >= planeCount)
         {
            return null;
         }
         var _loc2_:RoomPlaneData = var_105[param1] as RoomPlaneData;
         if(_loc2_ != null)
         {
            return _loc2_.rightSide;
         }
         return null;
      }
      
      public function set floorThickness(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         var_114 = param1;
      }
      
      public function get wallHeight() : Number
      {
         return var_1131;
      }
      
      private function extractLeftWall(param1:Point) : Point
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:int = 1;
         while(_loc2_ < 1000)
         {
            if(getTileHeightInternal(param1.x,param1.y - _loc2_) != TILE_BLOCKED)
            {
               return new Point(param1.x,param1.y - (_loc2_ - 1));
            }
            if(getTileHeightInternal(param1.x + 1,param1.y - _loc2_) == TILE_BLOCKED)
            {
               return new Point(param1.x + 1,param1.y - _loc2_);
            }
            _loc2_++;
         }
         return null;
      }
      
      public function get planeCount() : int
      {
         return var_105.length;
      }
      
      public function get tileMapHeight() : int
      {
         return _height;
      }
      
      public function get tileMapWidth() : int
      {
         return _width;
      }
      
      public function set wallThickness(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         var_761 = param1;
      }
      
      private function createWallPlanes() : Boolean
      {
         var _loc25_:* = null;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         var _loc29_:* = null;
         var _loc30_:int = 0;
         var _loc31_:int = 0;
         var _loc32_:int = 0;
         var _loc33_:Boolean = false;
         var _loc34_:* = null;
         var _loc35_:* = null;
         var _loc36_:* = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:* = null;
         var _loc39_:Number = NaN;
         var _loc40_:* = null;
         var _loc41_:* = null;
         var _loc42_:int = 0;
         var _loc43_:* = null;
         var _loc44_:Number = NaN;
         var _loc45_:Boolean = false;
         var _loc46_:Boolean = false;
         var _loc47_:Boolean = false;
         var _loc1_:Array = var_104;
         if(_loc1_ == null)
         {
            return false;
         }
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:int = _loc1_.length;
         var _loc6_:int = 0;
         if(_loc5_ == 0)
         {
            return false;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc4_ = _loc1_[_loc2_] as Array;
            if(_loc4_ == null || _loc4_.length == 0)
            {
               return false;
            }
            if(_loc6_ > 0)
            {
               _loc6_ = Math.min(_loc6_,_loc4_.length);
            }
            else
            {
               _loc6_ = _loc4_.length;
            }
            _loc2_++;
         }
         var _loc7_:Number = getFloorHeight(_loc1_);
         var _loc8_:int = minX;
         var _loc9_:int = minY;
         _loc9_ = minY;
         while(_loc9_ <= maxY)
         {
            if(getTileHeightInternal(_loc8_,_loc9_) != TILE_BLOCKED)
            {
               _loc9_--;
               break;
            }
            _loc9_++;
         }
         var _loc10_:Array = [extractTopWall,extractRightWall,extractBottomWall,extractLeftWall];
         var _loc11_:int = 0;
         var _loc12_:Point = new Point(_loc8_,_loc9_);
         var _loc13_:Point = new Point(_loc8_,_loc9_);
         var _loc14_:int = 0;
         var _loc15_:* = [];
         var _loc16_:* = [];
         var _loc17_:* = [];
         var _loc18_:* = [];
         var _loc19_:* = [];
         var _loc20_:* = [];
         var _loc21_:int = 0;
         var _loc22_:Boolean = true;
         while(_loc14_ < 1000)
         {
            _loc15_.push(_loc13_);
            _loc16_.push(_loc11_);
            _loc20_.push(false);
            if(_loc13_.x < minX || _loc13_.x > maxX || _loc13_.y < minY || _loc13_.y > maxY)
            {
               _loc19_.push(true);
            }
            else
            {
               _loc19_.push(false);
            }
            _loc25_ = _loc10_[_loc11_](_loc13_);
            if(_loc25_ == null)
            {
               _loc22_ = false;
               break;
            }
            _loc21_ = Math.abs(_loc25_.x - _loc13_.x) + Math.abs(_loc25_.y - _loc13_.y);
            if(_loc13_.x == _loc25_.x || _loc13_.y == _loc25_.y)
            {
               _loc11_ = (_loc11_ - 1 + _loc10_.length) % _loc10_.length;
               _loc21_ += 1;
               _loc18_.push(true);
            }
            else
            {
               _loc11_ = (_loc11_ + 1) % _loc10_.length;
               _loc21_--;
               _loc18_.push(false);
            }
            _loc17_.push(_loc21_);
            if(_loc25_.x == _loc12_.x && _loc25_.y == _loc12_.y && (_loc25_.x != _loc13_.x || _loc25_.y != _loc13_.y))
            {
               break;
            }
            _loc13_ = _loc25_;
            _loc14_++;
         }
         var _loc23_:* = [];
         _loc23_.push(new Vector3d(1,0,0));
         _loc23_.push(new Vector3d(0,1,0));
         _loc23_.push(new Vector3d(-1,0,0));
         _loc23_.push(new Vector3d(0,-1,0));
         var _loc24_:* = [];
         _loc24_.push(new Vector3d(0,1,0));
         _loc24_.push(new Vector3d(-1,0,0));
         _loc24_.push(new Vector3d(0,-1,0));
         _loc24_.push(new Vector3d(1,0,0));
         if(_loc15_.length != _loc16_.length || _loc16_.length != _loc17_.length || _loc17_.length != _loc18_.length || _loc18_.length != _loc19_.length)
         {
            _loc22_ = false;
         }
         if(_loc22_)
         {
            _loc26_ = _loc15_.length;
            _loc27_ = 0;
            _loc28_ = 0;
            _loc29_ = null;
            _loc2_ = 0;
            while(_loc2_ < _loc26_)
            {
               _loc30_ = _loc2_;
               _loc31_ = _loc2_;
               _loc32_ = 0;
               _loc33_ = false;
               while(!_loc19_[_loc2_] && _loc2_ < _loc26_)
               {
                  if(_loc18_[_loc2_])
                  {
                     _loc32_++;
                  }
                  else if(_loc32_ > 0)
                  {
                     _loc32_--;
                  }
                  if(_loc32_ > 1)
                  {
                     _loc33_ = true;
                  }
                  _loc31_ = _loc2_;
                  _loc2_++;
               }
               if(_loc33_)
               {
                  _loc3_ = _loc30_;
                  while(_loc3_ <= _loc31_)
                  {
                     _loc20_[_loc3_] = true;
                     _loc3_++;
                  }
               }
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < _loc26_)
            {
               _loc29_ = _loc15_[_loc2_] as Point;
               _loc27_ = _loc16_[_loc2_];
               _loc21_ = _loc17_[_loc2_];
               _loc34_ = _loc23_[_loc27_];
               _loc35_ = _loc24_[_loc27_];
               _loc36_ = -1;
               _loc3_ = 0;
               while(_loc3_ < _loc21_)
               {
                  _loc44_ = getTileHeightInternal(_loc29_.x + _loc3_ * _loc34_.x + _loc35_.x,_loc29_.y + _loc3_ * _loc34_.y + _loc35_.y);
                  if(_loc44_ >= 0 && (_loc44_ < _loc36_ || _loc36_ < 0))
                  {
                     _loc36_ = Number(_loc44_);
                  }
                  _loc3_++;
               }
               _loc37_ = _loc36_;
               _loc38_ = new Vector3d(_loc29_.x,_loc29_.y,_loc37_);
               _loc38_ = Vector3d.sum(_loc38_,Vector3d.product(_loc35_,0.5));
               _loc38_ = Vector3d.sum(_loc38_,Vector3d.product(_loc34_,-0.5));
               _loc39_ = wallHeight + _loc7_ - _loc36_;
               _loc40_ = Vector3d.product(_loc34_,-_loc21_);
               _loc41_ = new Vector3d(0,0,_loc39_);
               _loc38_ = Vector3d.dif(_loc38_,_loc40_);
               _loc28_ = _loc16_[(_loc2_ + 1) % _loc16_.length];
               _loc42_ = _loc16_[(_loc2_ - 1 + _loc16_.length) % _loc16_.length];
               _loc43_ = null;
               if((_loc28_ - _loc27_ + 4) % 4 == 3)
               {
                  _loc43_ = _loc24_[_loc28_];
               }
               else if((_loc27_ - _loc42_ + 4) % 4 == 3)
               {
                  _loc43_ = _loc24_[_loc42_];
               }
               if(!_loc20_[_loc2_])
               {
                  _loc45_ = _loc18_[_loc2_];
                  _loc46_ = _loc18_[(_loc2_ - 1 + _loc26_) % _loc26_];
                  _loc47_ = _loc20_[(_loc2_ + 1) % _loc26_];
                  addWall(_loc38_,_loc40_,_loc41_,_loc43_,!_loc46_,!_loc45_,!_loc47_);
               }
               _loc2_++;
            }
         }
         _loc3_ = 0;
         while(_loc3_ < tileMapHeight)
         {
            _loc2_ = 0;
            while(_loc2_ < tileMapWidth)
            {
               if(getTileHeightInternal(_loc2_,_loc3_) < 0)
               {
                  setTileHeight(_loc2_,_loc3_,-(_loc7_ + wallHeight));
               }
               _loc2_++;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function initializeTileMap(param1:int, param2:int) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         var_104 = [];
         var _loc3_:int = 0;
         while(_loc3_ < param2)
         {
            _loc4_ = [];
            _loc5_ = 0;
            while(_loc5_ < param1)
            {
               _loc4_[_loc5_] = TILE_BLOCKED;
               _loc5_++;
            }
            var_104.push(_loc4_);
            _loc3_++;
         }
         _width = param1;
         _height = param2;
         var_320 = _width;
         var_321 = -1;
         var_322 = _height;
         var_323 = -1;
         return true;
      }
      
      public function dispose() : void
      {
         var_105 = null;
         var_104 = null;
      }
      
      private function extractFloorPlane(param1:Array, param2:Boolean) : Boolean
      {
         if(param1 == null || var_104 == null || param1 == var_104)
         {
            return false;
         }
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(param1.length > var_104.length)
         {
            return false;
         }
         var _loc7_:int = param1.length;
         var _loc8_:int = 0;
         if(_loc7_ == 0)
         {
            return false;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc7_)
         {
            _loc5_ = param1[_loc3_] as Array;
            _loc6_ = var_104[_loc3_] as Array;
            if(_loc5_ == null || _loc5_.length == 0)
            {
               return false;
            }
            if(_loc6_ == null || _loc6_.length == 0)
            {
               return false;
            }
            if(_loc5_.length != _loc6_.length)
            {
               return false;
            }
            if(_loc8_ > 0)
            {
               _loc8_ = Math.min(_loc8_,_loc5_.length);
            }
            else
            {
               _loc8_ = _loc5_.length;
            }
            _loc3_++;
         }
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = _loc8_;
         var _loc12_:int = 0;
         var _loc13_:* = -1;
         var _loc14_:* = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc5_ = param1[_loc4_] as Array;
            _loc6_ = param1[_loc10_] as Array;
            if(_loc13_ >= 0)
            {
               if(_loc9_ > 0 && Number(_loc5_[_loc9_ - 1]) != Number(_loc6_[_loc9_ - 1]))
               {
                  _loc12_ = _loc4_;
                  break;
               }
               if(_loc11_ < _loc8_ && _loc5_[_loc11_] != Number(_loc6_[_loc11_]))
               {
                  _loc12_ = _loc4_;
                  break;
               }
            }
            _loc3_ = _loc9_;
            while(_loc3_ < _loc11_)
            {
               _loc14_ = Number(Number(_loc5_[_loc3_]));
               if(_loc14_ >= 0)
               {
                  if(_loc13_ < 0)
                  {
                     _loc10_ = _loc4_;
                     _loc9_ = _loc3_;
                     _loc13_ = Number(_loc14_);
                  }
                  else if(_loc14_ != _loc13_)
                  {
                     if(_loc4_ > _loc10_)
                     {
                        _loc12_ = _loc4_;
                        _loc4_ = _loc7_;
                        break;
                     }
                     _loc11_ = _loc3_;
                  }
               }
               else if(_loc13_ >= 0)
               {
                  if(_loc4_ == _loc10_)
                  {
                     _loc11_ = _loc3_;
                  }
                  else if(_loc3_ < _loc11_)
                  {
                     _loc12_ = _loc4_;
                     _loc4_ = _loc7_;
                     break;
                  }
               }
               _loc12_ = _loc4_ + 1;
               _loc3_++;
            }
            _loc4_++;
         }
         if(_loc13_ < 0)
         {
            return false;
         }
         if(_loc11_ - _loc9_ < 1)
         {
            return false;
         }
         if(_loc12_ - _loc10_ < 1)
         {
            return false;
         }
         if(_loc10_ > 0)
         {
            _loc5_ = param1[_loc10_ - 1];
         }
         else
         {
            _loc5_ = null;
         }
         _loc6_ = param1[_loc12_];
         _loc3_ = _loc9_ + 1;
         while(_loc3_ < _loc11_)
         {
            if(_loc5_ != null && _loc5_[_loc3_] >= -1 != _loc5_[_loc9_] >= -1 || _loc6_[_loc3_] >= -1 != _loc6_[_loc9_] >= -1)
            {
               _loc11_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         _loc5_ = param1[_loc10_];
         _loc3_ = _loc10_ + 1;
         while(_loc3_ < _loc12_)
         {
            _loc6_ = param1[_loc3_];
            if(_loc9_ > 0 && _loc5_[_loc9_ - 1] >= -1 != _loc6_[_loc9_ - 1] >= -1 || _loc11_ < _loc8_ && _loc5_[_loc11_] >= -1 != _loc6_[_loc11_] >= -1)
            {
               _loc12_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         var _loc17_:Number = _loc11_ - _loc9_;
         var _loc18_:Number = _loc12_ - _loc10_;
         var _loc19_:int = 1;
         var _loc20_:int = 1;
         var _loc21_:int = 1;
         var _loc22_:int = 1;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         if(_loc10_ < 1)
         {
            _loc19_ = 0;
         }
         if(_loc12_ > _loc7_ - 1)
         {
            _loc20_ = 0;
         }
         if(_loc9_ < 1)
         {
            _loc21_ = 0;
         }
         if(_loc11_ > _loc8_ - 2)
         {
            _loc22_ = 0;
         }
         var _loc27_:int = 0;
         _loc3_ = _loc9_;
         while(_loc3_ < _loc11_)
         {
            if(_loc19_)
            {
               _loc27_ = Math.abs(getTileHeightInternal(_loc3_,_loc10_ - 1) - getTileHeightInternal(_loc3_,_loc10_));
               if(_loc27_ != 1)
               {
                  _loc19_ = 0;
               }
               else
               {
                  _loc19_ = getTileHeightInternal(_loc3_,_loc10_ - 1) - getTileHeightInternal(_loc3_,_loc10_);
               }
            }
            if(getTileHeightInternal(_loc3_,_loc10_ - 1) < _loc13_)
            {
               _loc23_++;
            }
            _loc3_++;
         }
         _loc3_ = _loc9_;
         while(_loc3_ < _loc11_)
         {
            if(_loc20_)
            {
               _loc27_ = Math.abs(getTileHeightInternal(_loc3_,_loc12_) - getTileHeightInternal(_loc3_,_loc12_ - 1));
               if(_loc27_ != 1)
               {
                  _loc20_ = 0;
               }
               else
               {
                  _loc20_ = getTileHeightInternal(_loc3_,_loc12_) - getTileHeightInternal(_loc3_,_loc12_ - 1);
               }
            }
            if(getTileHeightInternal(_loc3_,_loc12_) < _loc13_)
            {
               _loc24_++;
            }
            _loc3_++;
         }
         _loc3_ = _loc10_;
         while(_loc3_ < _loc12_)
         {
            if(_loc21_)
            {
               _loc27_ = Math.abs(getTileHeight(_loc9_ - 1,_loc3_) - getTileHeight(_loc9_,_loc3_));
               if(_loc27_ != 1)
               {
                  _loc21_ = 0;
               }
               else
               {
                  _loc21_ = getTileHeight(_loc9_ - 1,_loc3_) - getTileHeight(_loc9_,_loc3_);
               }
            }
            if(_loc22_)
            {
               _loc27_ = Math.abs(getTileHeight(_loc11_,_loc3_) - getTileHeight(_loc11_ - 1,_loc3_));
               if(_loc27_ != 1)
               {
                  _loc22_ = 0;
               }
               else
               {
                  _loc22_ = getTileHeight(_loc11_,_loc3_) - getTileHeight(_loc11_ - 1,_loc3_);
               }
            }
            if(getTileHeightInternal(_loc9_ - 1,_loc3_) < _loc13_)
            {
               _loc25_++;
            }
            if(getTileHeightInternal(_loc11_,_loc3_) < _loc13_)
            {
               _loc26_++;
            }
            _loc3_++;
         }
         var _loc28_:Number = _loc13_;
         var _loc29_:Number = _loc9_ - 0.5;
         var _loc30_:Number = _loc10_ - 0.5;
         var _loc31_:int = 1;
         var _loc32_:int = 1;
         var _loc33_:int = 1;
         var _loc34_:int = 1;
         if(_loc19_)
         {
            if(_loc19_ > 0)
            {
               _loc33_ = 0;
               _loc34_ = 1;
            }
            else
            {
               _loc33_ = 1;
               _loc34_ = 0;
            }
            addFloor(new Vector3d(_loc29_ + _loc17_,_loc30_ + 0.34,_loc28_ + _loc19_ / 4 * 2),new Vector3d(-_loc17_,0,0),new Vector3d(0,-0.34,0),_loc26_ > 0,_loc25_ > 0,_loc34_ > 0,_loc33_ > 0,0,0,0,0);
            addFloor(new Vector3d(_loc29_ + _loc17_,_loc30_ + 0.67,_loc28_ + _loc19_ / 4),new Vector3d(-_loc17_,0,0),new Vector3d(0,-0.33,0),_loc26_ > 0,_loc25_ > 0,_loc34_ > 0,_loc33_ > 0,0,0,0,0);
         }
         if(_loc20_)
         {
            if(_loc20_ < 0)
            {
               _loc33_ = 0;
               _loc34_ = 1;
            }
            else
            {
               _loc33_ = 1;
               _loc34_ = 0;
            }
            addFloor(new Vector3d(_loc29_ + _loc17_,_loc30_ + _loc18_,_loc28_ + _loc20_ / 4),new Vector3d(-_loc17_,0,0),new Vector3d(0,-0.33,0),_loc26_ > 0,_loc25_ > 0,_loc34_ > 0,_loc33_ > 0,0,0,0,0);
         }
         if(_loc21_)
         {
            if(_loc21_ > 0)
            {
               _loc31_ = 0;
               _loc32_ = 1;
            }
            else
            {
               _loc31_ = 1;
               _loc32_ = 0;
            }
            addFloor(new Vector3d(_loc29_ + 0.34,_loc30_ + _loc18_,_loc28_ + _loc21_ / 4 * 2),new Vector3d(-0.34,0,0),new Vector3d(0,-_loc18_,0),_loc32_ > 0,_loc31_ > 0,_loc24_ > 0,_loc23_ > 0,0,0,0,0);
            addFloor(new Vector3d(_loc29_ + 0.67,_loc30_ + _loc18_,_loc28_ + _loc21_ / 4),new Vector3d(-0.33,0,0),new Vector3d(0,-_loc18_,0),_loc32_ > 0,_loc31_ > 0,_loc24_ > 0,_loc23_ > 0,0,0,0,0);
         }
         if(_loc22_)
         {
            if(_loc22_ < 0)
            {
               _loc31_ = 0;
               _loc32_ = 1;
            }
            else
            {
               _loc31_ = 1;
               _loc32_ = 0;
            }
            addFloor(new Vector3d(_loc29_ + _loc17_,_loc30_ + _loc18_,_loc28_ + _loc22_ / 4),new Vector3d(-0.33,0,0),new Vector3d(0,-_loc18_,0),_loc32_ > 0,_loc31_ > 0,_loc24_ > 0,_loc23_ > 0,0,0,0,0);
         }
         _loc4_ = _loc10_;
         while(_loc4_ < _loc12_)
         {
            _loc5_ = param1[_loc4_];
            _loc3_ = _loc9_;
            while(_loc3_ < _loc11_)
            {
               _loc5_[_loc3_] = -1;
               _loc3_++;
            }
            _loc4_++;
         }
         var _loc35_:* = 0;
         var _loc36_:* = 0;
         var _loc37_:* = 0;
         var _loc38_:* = 0;
         if(_loc21_)
         {
            _loc36_ = 0.65;
         }
         if(_loc22_)
         {
            _loc35_ = 0.3;
         }
         if(_loc19_)
         {
            _loc38_ = 0.65;
         }
         if(_loc20_)
         {
            _loc37_ = 0.3;
         }
         if(!param2)
         {
            _loc25_ = 0;
            _loc26_ = 0;
            _loc23_ = 0;
            _loc24_ = 0;
         }
         addFloor(new Vector3d(_loc29_ + _loc17_,_loc30_ + _loc18_,_loc28_),new Vector3d(-_loc17_,0,0),new Vector3d(0,-_loc18_,0),_loc26_ > 0,_loc25_ > 0,_loc24_ > 0,_loc23_ > 0,_loc35_,_loc36_,_loc37_,_loc38_);
         return true;
      }
      
      public function set wallHeight(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         var_1131 = param1;
      }
      
      public function getPlaneNormal(param1:int) : IVector3d
      {
         if(param1 < 0 || param1 >= planeCount)
         {
            return null;
         }
         var _loc2_:RoomPlaneData = var_105[param1] as RoomPlaneData;
         if(_loc2_ != null)
         {
            return _loc2_.normal;
         }
         return null;
      }
      
      public function addPlane(param1:int, param2:IVector3d, param3:IVector3d, param4:IVector3d, param5:Array = null) : RoomPlaneData
      {
         if(param3.length == 0 || param4.length == 0)
         {
            return null;
         }
         var _loc6_:RoomPlaneData = new RoomPlaneData(param1,param2,param3,param4,param5);
         var_105.push(_loc6_);
         return _loc6_;
      }
      
      public function getPlaneSecondaryNormals(param1:int) : Array
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         if(param1 < 0 || param1 >= planeCount)
         {
            return null;
         }
         var _loc2_:RoomPlaneData = var_105[param1] as RoomPlaneData;
         if(_loc2_ != null)
         {
            _loc3_ = [];
            _loc4_ = 0;
            while(_loc4_ < _loc2_.secondaryNormalCount)
            {
               _loc3_.push(_loc2_.getSecondaryNormal(_loc4_));
               _loc4_++;
            }
            return _loc3_;
         }
         return null;
      }
      
      public function getPlaneLeftSide(param1:int) : IVector3d
      {
         if(param1 < 0 || param1 >= planeCount)
         {
            return null;
         }
         var _loc2_:RoomPlaneData = var_105[param1] as RoomPlaneData;
         if(_loc2_ != null)
         {
            return _loc2_.leftSide;
         }
         return null;
      }
      
      public function get floorThickness() : Number
      {
         return var_114;
      }
      
      public function get minX() : int
      {
         return var_320;
      }
      
      private function getTileHeightInternal(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= _width || param2 < 0 || param2 >= _height)
         {
            return TILE_BLOCKED;
         }
         var _loc3_:Array = var_104[param2] as Array;
         return _loc3_[param1] as Number;
      }
      
      public function getPlaneMaskLeftSideLoc(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= planeCount)
         {
            return -1;
         }
         var _loc3_:RoomPlaneData = var_105[param1] as RoomPlaneData;
         if(_loc3_ != null)
         {
            return _loc3_.getMaskLeftSideLoc(param2);
         }
         return -1;
      }
      
      public function get wallThickness() : Number
      {
         return var_761;
      }
      
      public function getPlaneNormalDirection(param1:int) : IVector3d
      {
         if(param1 < 0 || param1 >= planeCount)
         {
            return null;
         }
         var _loc2_:RoomPlaneData = var_105[param1] as RoomPlaneData;
         if(_loc2_ != null)
         {
            return _loc2_.normalDirection;
         }
         return null;
      }
      
      public function get minY() : int
      {
         return var_322;
      }
      
      public function get floorHeight() : Number
      {
         return var_565;
      }
      
      public function initializeFromXML(param1:XML) : Boolean
      {
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:int = 0;
         var _loc18_:* = null;
         var _loc19_:* = null;
         var _loc20_:int = 0;
         var _loc21_:* = null;
         var _loc22_:* = null;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:* = ["id","type"];
         var _loc3_:* = ["x","y","z"];
         var _loc4_:* = ["leftSideLoc","rightSideLoc","leftSideLength","rightSideLength"];
         var _loc6_:XMLList = param1.planes.plane;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_.length())
         {
            _loc8_ = _loc6_[_loc7_];
            if(!XMLValidator.checkRequiredAttributes(_loc8_,_loc2_))
            {
               return false;
            }
            _loc9_ = _loc8_.@id;
            _loc10_ = int(_loc8_.@type);
            _loc11_ = null;
            _loc12_ = null;
            _loc13_ = null;
            _loc14_ = [];
            _loc15_ = _loc8_.location;
            if(_loc15_.length() != 1)
            {
               return false;
            }
            _loc16_ = _loc15_[0];
            if(!XMLValidator.checkRequiredAttributes(_loc16_,_loc3_))
            {
               return false;
            }
            _loc11_ = new Vector3d(Number(_loc16_.@x),Number(_loc16_.@y),Number(_loc16_.@z));
            _loc15_ = _loc8_.leftSide;
            if(_loc15_.length() != 1)
            {
               return false;
            }
            _loc16_ = _loc15_[0];
            if(!XMLValidator.checkRequiredAttributes(_loc16_,_loc3_))
            {
               return false;
            }
            _loc12_ = new Vector3d(Number(_loc16_.@x),Number(_loc16_.@y),Number(_loc16_.@z));
            _loc15_ = _loc8_.rightSide;
            if(_loc15_.length() != 1)
            {
               return false;
            }
            _loc16_ = _loc15_[0];
            if(!XMLValidator.checkRequiredAttributes(_loc16_,_loc3_))
            {
               return false;
            }
            _loc13_ = new Vector3d(Number(_loc16_.@x),Number(_loc16_.@y),Number(_loc16_.@z));
            _loc15_ = _loc8_.secondaryNormal;
            _loc17_ = 0;
            while(_loc17_ < _loc15_.length())
            {
               _loc16_ = _loc15_[_loc17_];
               if(XMLValidator.checkRequiredAttributes(_loc16_,_loc3_))
               {
                  _loc21_ = new Vector3d(Number(_loc16_.@x),Number(_loc16_.@y),Number(_loc16_.@z));
                  _loc14_.push(_loc21_);
               }
               _loc17_++;
            }
            _loc18_ = new RoomPlaneData(_loc10_,_loc11_,_loc12_,_loc13_,_loc14_);
            var_105.push(_loc18_);
            _loc19_ = _loc8_.masks.mask;
            _loc20_ = 0;
            while(_loc20_ < _loc19_.length())
            {
               _loc22_ = _loc19_[_loc20_];
               if(XMLValidator.checkRequiredAttributes(_loc22_,_loc4_))
               {
                  _loc23_ = Number(_loc22_.@leftSideLoc);
                  _loc24_ = Number(_loc22_.@rightSideLoc);
                  _loc25_ = Number(_loc22_.@leftSideLength);
                  _loc26_ = Number(_loc22_.@rightSideLength);
                  _loc18_.addMask(_loc23_,_loc24_,_loc25_,_loc26_);
               }
               _loc20_++;
            }
            _loc7_++;
         }
         return true;
      }
      
      public function reset() : void
      {
         var_105 = [];
         var_104 = [];
      }
      
      public function getPlaneMaskRightSideLength(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= planeCount)
         {
            return -1;
         }
         var _loc3_:RoomPlaneData = var_105[param1] as RoomPlaneData;
         if(_loc3_ != null)
         {
            return _loc3_.getMaskRightSideLength(param2);
         }
         return -1;
      }
      
      public function getXML() : XML
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:int = 0;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc1_:XML = <planes/>;
         var _loc2_:int = 0;
         while(_loc2_ < planeCount)
         {
            _loc4_ = getPlaneType(_loc2_);
            _loc5_ = <plane id="{_loc2_}" type="{_loc4_}"/>;
            _loc6_ = getPlaneLocation(_loc2_);
            _loc7_ = getPlaneLeftSide(_loc2_);
            _loc8_ = getPlaneRightSide(_loc2_);
            _loc9_ = getPlaneSecondaryNormals(_loc2_);
            if(_loc6_ != null && _loc7_ != null && _loc8_ != null)
            {
               _loc5_.appendChild(<location x="{_loc6_.x}" y="{_loc6_.y}" z="{_loc6_.z}"/>);
               _loc5_.appendChild(<leftSide x="{_loc7_.x}" y="{_loc7_.y}" z="{_loc7_.z}"/>);
               _loc5_.appendChild(<rightSide x="{_loc8_.x}" y="{_loc8_.y}" z="{_loc8_.z}"/>);
               if(_loc9_ != null)
               {
                  _loc10_ = 0;
                  while(_loc10_ < _loc9_.length)
                  {
                     _loc11_ = _loc9_[_loc10_];
                     if(_loc11_ != null)
                     {
                        _loc5_.appendChild(<secondaryNormal x="{_loc11_.x}" y="{_loc11_.y}" z="{_loc11_.z}"/>);
                     }
                     _loc10_++;
                  }
               }
               if(getPlaneMaskCount(_loc2_) > 0)
               {
                  _loc12_ = <masks/>;
                  _loc13_ = 0;
                  while(_loc13_ < getPlaneMaskCount(_loc2_))
                  {
                     _loc14_ = getPlaneMaskLeftSideLoc(_loc2_,_loc13_);
                     _loc15_ = getPlaneMaskRightSideLoc(_loc2_,_loc13_);
                     _loc16_ = getPlaneMaskLeftSideLength(_loc2_,_loc13_);
                     _loc17_ = getPlaneMaskRightSideLength(_loc2_,_loc13_);
                     _loc12_.appendChild(<mask leftSideLoc="{_loc14_}" rightSideLoc="{_loc15_}" leftSideLength="{_loc16_}" rightSideLength="{_loc17_}"/>);
                     _loc13_++;
                  }
                  _loc5_.appendChild(_loc12_);
               }
               _loc1_.appendChild(_loc5_);
            }
            _loc2_++;
         }
         var _loc3_:XML = <roomData/>;
         _loc3_.appendChild(_loc1_);
         return _loc3_;
      }
      
      public function getPlaneMaskLeftSideLength(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= planeCount)
         {
            return -1;
         }
         var _loc3_:RoomPlaneData = var_105[param1] as RoomPlaneData;
         if(_loc3_ != null)
         {
            return _loc3_.getMaskLeftSideLength(param2);
         }
         return -1;
      }
      
      public function getTileHeight(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= _width || param2 < 0 || param2 >= _height)
         {
            return TILE_BLOCKED;
         }
         var _loc3_:Array = var_104[param2] as Array;
         return Math.abs(_loc3_[param1] as Number);
      }
      
      public function initializeFromTileData(param1:Boolean = false) : Boolean
      {
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc2_:Point = findEntranceTile(var_104);
         var _loc3_:int = 0;
         if(_loc2_ != null)
         {
            _loc3_ = getTileHeight(_loc2_.x,_loc2_.y);
            setTileHeight(_loc2_.x,_loc2_.y,TILE_BLOCKED);
         }
         var_565 = getFloorHeight(var_104);
         if(!param1)
         {
            createWallPlanes();
         }
         var _loc4_:* = null;
         var _loc5_:* = [];
         var _loc6_:int = 0;
         while(_loc6_ < var_104.length)
         {
            _loc4_ = var_104[_loc6_];
            _loc7_ = [];
            _loc8_ = 0;
            while(_loc8_ < _loc4_.length)
            {
               _loc7_.push(_loc4_[_loc8_]);
               _loc8_++;
            }
            _loc5_.push(_loc7_);
            _loc6_++;
         }
         while(extractFloorPlane(_loc5_,true))
         {
         }
         if(_loc2_ != null)
         {
            setTileHeight(_loc2_.x,_loc2_.y,_loc3_);
            _loc4_ = _loc5_[_loc2_.y];
            _loc4_[_loc2_.x] = _loc3_;
            extractFloorPlane(_loc5_,false);
         }
         return true;
      }
      
      public function get maxX() : int
      {
         return var_321;
      }
      
      public function get maxY() : int
      {
         return var_323;
      }
      
      private function extractBottomWall(param1:Point) : Point
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:int = 1;
         while(_loc2_ < 1000)
         {
            if(getTileHeightInternal(param1.x - _loc2_,param1.y) != TILE_BLOCKED)
            {
               return new Point(param1.x - (_loc2_ - 1),param1.y);
            }
            if(getTileHeightInternal(param1.x - _loc2_,param1.y - 1) == TILE_BLOCKED)
            {
               return new Point(param1.x - _loc2_,param1.y - 1);
            }
            _loc2_++;
         }
         return null;
      }
      
      public function setTileHeight(param1:int, param2:int, param3:Number) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         if(param1 >= 0 && param1 < _width && param2 >= 0 && param2 < _height)
         {
            _loc4_ = var_104[param2] as Array;
            _loc4_[param1] = param3;
            if(param3 >= 0)
            {
               if(param1 < var_320)
               {
                  var_320 = param1;
               }
               if(param1 > var_321)
               {
                  var_321 = param1;
               }
               if(param2 < var_322)
               {
                  var_322 = param2;
               }
               if(param2 > var_323)
               {
                  var_323 = param2;
               }
            }
            else
            {
               if(param1 == var_320 || param1 == var_321)
               {
                  _loc5_ = false;
                  _loc6_ = var_322;
                  while(_loc6_ < var_323)
                  {
                     if(getTileHeightInternal(param1,_loc6_) >= 0)
                     {
                        _loc5_ = true;
                        break;
                     }
                     _loc6_++;
                  }
                  if(!_loc5_)
                  {
                     if(param1 == var_320)
                     {
                        ++var_320;
                     }
                     if(param1 == var_321)
                     {
                        --var_321;
                     }
                  }
               }
               if(param2 == var_322 || param2 == var_323)
               {
                  _loc7_ = false;
                  _loc8_ = var_320;
                  while(_loc8_ < var_321)
                  {
                     if(getTileHeight(_loc8_,param2) >= 0)
                     {
                        _loc7_ = true;
                        break;
                     }
                     _loc8_++;
                  }
                  if(!_loc7_)
                  {
                     if(param2 == var_322)
                     {
                        ++var_322;
                     }
                     if(param2 == var_323)
                     {
                        --var_323;
                     }
                  }
               }
            }
            return true;
         }
         return false;
      }
      
      private function addFloor(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Number, param9:Number, param10:Number, param11:Number) : void
      {
         var _loc12_:RoomPlaneData = addPlane(RoomPlaneData.const_136,param1,param2,param3);
         var _loc13_:IVector3d = param1;
         var _loc14_:* = null;
         var _loc15_:* = null;
         if(_loc12_)
         {
            if(param8 > 0)
            {
               _loc12_.addMask(0,0,param8,param3.length);
            }
            if(param9 > 0)
            {
               _loc12_.addMask(param2.length - param9,0,param9,param3.length);
            }
            if(param10 > 0)
            {
               _loc12_.addMask(0,0,param2.length,param10);
            }
            if(param11 > 0)
            {
               _loc12_.addMask(0,param3.length - param11,param2.length,param11);
            }
            if(param6)
            {
               if(param10 > 0)
               {
                  _loc13_ = Vector3d.sum(param1,Vector3d.product(param3,param10 / param3.length));
               }
               else
               {
                  _loc13_ = param1;
               }
               _loc14_ = addPlane(RoomPlaneData.const_136,_loc13_,new Vector3d(0,0,-var_114),param2);
               if(_loc14_ != null)
               {
                  if(param8 > 0)
                  {
                     _loc14_.addMask(0,0,var_114,param8);
                  }
                  if(param9 > 0)
                  {
                     _loc14_.addMask(0,param2.length - param9,var_114,param9);
                  }
               }
            }
            if(param7)
            {
               if(param11 > 0)
               {
                  _loc13_ = Vector3d.sum(param1,Vector3d.sum(param2,Vector3d.product(param3,1 - param11 / param3.length)));
               }
               else
               {
                  _loc13_ = Vector3d.sum(param1,Vector3d.sum(param2,param3));
               }
               _loc14_ = addPlane(RoomPlaneData.const_136,_loc13_,new Vector3d(0,0,-var_114),Vector3d.product(param2,-1));
               if(_loc14_ != null)
               {
                  if(param9 > 0)
                  {
                     _loc14_.addMask(0,0,var_114,param9);
                  }
                  if(param8 > 0)
                  {
                     _loc14_.addMask(0,param2.length - param8,var_114,param8);
                  }
               }
            }
            if(param4)
            {
               if(param8 > 0)
               {
                  _loc13_ = Vector3d.sum(param1,Vector3d.sum(param3,Vector3d.product(param2,param8 / param2.length)));
               }
               else
               {
                  _loc13_ = Vector3d.sum(param1,param3);
               }
               _loc15_ = addPlane(RoomPlaneData.const_136,_loc13_,new Vector3d(0,0,-var_114),Vector3d.product(param3,-1));
               if(_loc15_ != null)
               {
                  if(param11 > 0)
                  {
                     _loc15_.addMask(0,0,param11,var_114);
                  }
                  if(param10 > 0)
                  {
                     _loc15_.addMask(param3.length - param10,0,param10,var_114);
                  }
               }
            }
            if(param5)
            {
               if(param9 > 0)
               {
                  _loc13_ = Vector3d.sum(param1,Vector3d.product(param2,1 - param9 / param2.length));
               }
               else
               {
                  _loc13_ = Vector3d.sum(param1,param2);
               }
               _loc15_ = addPlane(RoomPlaneData.const_136,_loc13_,new Vector3d(0,0,-var_114),param3);
               if(_loc15_ != null)
               {
                  if(param10 > 0)
                  {
                     _loc15_.addMask(0,0,param10,var_114);
                  }
                  if(param11 > 0)
                  {
                     _loc15_.addMask(param3.length - param11,0,param11,var_114);
                  }
               }
            }
         }
      }
      
      public function getPlaneLocation(param1:int) : IVector3d
      {
         if(param1 < 0 || param1 >= planeCount)
         {
            return null;
         }
         var _loc2_:RoomPlaneData = var_105[param1] as RoomPlaneData;
         if(_loc2_ != null)
         {
            return _loc2_.loc;
         }
         return null;
      }
      
      public function getPlaneMaskCount(param1:int) : int
      {
         if(param1 < 0 || param1 >= planeCount)
         {
            return 0;
         }
         var _loc2_:RoomPlaneData = var_105[param1] as RoomPlaneData;
         if(_loc2_ != null)
         {
            return _loc2_.maskCount;
         }
         return 0;
      }
      
      private function extractTopWall(param1:Point) : Point
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:int = 1;
         while(_loc2_ < 1000)
         {
            if(getTileHeightInternal(param1.x + _loc2_,param1.y) != TILE_BLOCKED)
            {
               return new Point(param1.x + _loc2_ - 1,param1.y);
            }
            if(getTileHeightInternal(param1.x + _loc2_,param1.y + 1) == TILE_BLOCKED)
            {
               return new Point(param1.x + _loc2_,param1.y + 1);
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getPlaneMaskRightSideLoc(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= planeCount)
         {
            return -1;
         }
         var _loc3_:RoomPlaneData = var_105[param1] as RoomPlaneData;
         if(_loc3_ != null)
         {
            return _loc3_.getMaskRightSideLoc(param2);
         }
         return -1;
      }
   }
}
