package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.room.object.RoomPlaneParser;
   
   public class FloorHeightMapMessageParser implements IMessageParser
   {
       
      
      private var _height:int = 0;
      
      private var _width:int = 0;
      
      private var var_179:Number = 0;
      
      private var _roomId:int = 0;
      
      private var _heightMap:Array;
      
      private var _roomCategory:int = 0;
      
      public function FloorHeightMapMessageParser()
      {
         _heightMap = [];
         super();
      }
      
      public function flush() : Boolean
      {
         _roomId = 0;
         _roomCategory = 0;
         _heightMap = [];
         _width = 0;
         _height = 0;
         return true;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get scale() : Number
      {
         return var_179;
      }
      
      public function getTileHeight(param1:int, param2:int) : int
      {
         if(param1 < 0 || param1 >= width || param2 < 0 || param2 >= height)
         {
            return RoomPlaneParser.TILE_BLOCKED;
         }
         var _loc3_:Array = _heightMap[param2] as Array;
         return _loc3_[param1];
      }
      
      private function getHeightValue(param1:String) : int
      {
         var _loc2_:int = parseInt(param1,16);
         return int(_loc2_ % 10);
      }
      
      public function get roomCategory() : int
      {
         return _roomCategory;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc13_:* = null;
         if(param1 == null)
         {
            return false;
         }
         var _loc4_:String = param1.readString();
         var _loc5_:Array = _loc4_.split("\r");
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc10_:int = _loc5_.length;
         var _loc11_:int = 0;
         var _loc12_:* = null;
         _loc7_ = 0;
         while(_loc7_ < _loc10_)
         {
            _loc12_ = _loc5_[_loc7_] as String;
            if(_loc12_.length > _loc11_)
            {
               _loc11_ = _loc12_.length;
            }
            _loc7_++;
         }
         _heightMap = [];
         _loc7_ = 0;
         while(_loc7_ < _loc10_)
         {
            _loc9_ = [];
            _loc6_ = 0;
            while(_loc6_ < _loc11_)
            {
               _loc9_.push(RoomPlaneParser.TILE_BLOCKED);
               _loc6_++;
            }
            _heightMap.push(_loc9_);
            _loc7_++;
         }
         _width = _loc11_;
         _height = _loc10_;
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc9_ = _heightMap[_loc7_] as Array;
            _loc12_ = _loc5_[_loc7_] as String;
            if(_loc12_.length > 0)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc12_.length)
               {
                  _loc13_ = _loc12_.charAt(_loc6_);
                  if(_loc13_ != "x" && _loc13_ != "X")
                  {
                     _loc8_ = getHeightValue(_loc13_);
                  }
                  else
                  {
                     _loc8_ = 0;
                  }
                  _loc9_[_loc6_] = _loc8_;
                  _loc6_++;
               }
            }
            _loc7_++;
         }
         if(_width >= 20 || _height >= 20)
         {
            var_179 = 32;
         }
         else
         {
            var_179 = 64;
         }
         return true;
      }
      
      public function get height() : int
      {
         return _height;
      }
   }
}
