package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class HeightMapUpdateMessageParser implements IMessageParser
   {
       
      
      private var var_194:Array;
      
      private var _roomId:int = 0;
      
      private var _heightMap:Array;
      
      private var _roomCategory:int = 0;
      
      public function HeightMapUpdateMessageParser()
      {
         _heightMap = [];
         var_194 = [];
         super();
      }
      
      public function get roomCategory() : int
      {
         return _roomCategory;
      }
      
      private function parseNormal(param1:String) : Boolean
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         if(String == null)
         {
            return false;
         }
         var _loc2_:Array = param1.split("\r");
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _heightMap = [];
         var_194 = [];
         var _loc5_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc6_ = _loc2_[_loc4_] as String;
            _loc3_ = 0;
            while(_loc3_ < _loc6_.length)
            {
               _loc7_ = _loc6_.charAt(_loc3_);
               if(_loc7_ != "x" && _loc7_ != "X")
               {
                  _loc5_ = getHeightValue(_loc7_) + 1;
                  _heightMap.push(_loc5_);
                  if(getBlocking(_loc7_))
                  {
                     var_194.push(true);
                  }
                  else
                  {
                     var_194.push(false);
                  }
               }
               else
               {
                  _heightMap.push(0);
                  var_194.push(true);
               }
               _loc3_++;
            }
            _loc4_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         _roomId = 0;
         _roomCategory = 0;
         _heightMap = [];
         var_194 = [];
         return true;
      }
      
      public function getTileHeight(param1:int, param2:int, param3:Number, param4:int, param5:int) : Number
      {
         if(param1 < 0 || param1 >= param4 || param2 < 0 || param2 >= param5)
         {
            return param3;
         }
         var _loc6_:int = param1 + param2 * param4;
         if(_loc6_ < 0 || _loc6_ >= _heightMap.length)
         {
            return param3;
         }
         var _loc7_:int = int(_heightMap[_loc6_]);
         if(_loc7_ == 0)
         {
            return param3;
         }
         return _loc7_ - 1;
      }
      
      private function getBlocking(param1:String) : Boolean
      {
         var _loc2_:int = parseInt(param1,16);
         return _loc2_ >= 10;
      }
      
      private function parseCompressed(param1:String) : Boolean
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _heightMap = [];
         var_194 = [];
         var _loc4_:int = 0;
         if(param1.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               _loc5_ = param1.charAt(_loc2_);
               if(_loc5_ == "!")
               {
                  _loc6_ = param1.charCodeAt(++_loc2_) - 32;
                  _loc3_ = 0;
                  while(_loc3_ < _loc6_)
                  {
                     _heightMap.push(0);
                     var_194.push(false);
                     _loc3_++;
                  }
               }
               else
               {
                  _loc4_ = getHeightValue(_loc5_) + 1;
                  _heightMap.push(_loc4_);
                  if(getBlocking(_loc5_))
                  {
                     var_194.push(true);
                  }
                  else
                  {
                     var_194.push(false);
                  }
               }
               _loc2_++;
            }
         }
         return true;
      }
      
      public function getTileBlocking(param1:int, param2:int, param3:Boolean, param4:int, param5:int) : Boolean
      {
         if(param1 < 0 || param1 >= param4 || param2 < 0 || param2 >= param5)
         {
            return param3;
         }
         var _loc6_:int = param1 + param2 * param4;
         if(_loc6_ < 0 || _loc6_ >= _heightMap.length || _loc6_ >= var_194.length)
         {
            return param3;
         }
         var _loc7_:int = int(_heightMap[_loc6_]);
         if(_loc7_ == 0)
         {
            return param3;
         }
         return var_194[_loc6_];
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc4_:String = param1.readString();
         if(_loc4_.indexOf("x") == 0 || _loc4_.indexOf("X") == 0)
         {
            return parseNormal(_loc4_);
         }
         return parseCompressed(_loc4_);
      }
      
      private function getHeightValue(param1:String) : int
      {
         var _loc2_:int = parseInt(param1,16);
         return int(_loc2_ % 10);
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
   }
}
