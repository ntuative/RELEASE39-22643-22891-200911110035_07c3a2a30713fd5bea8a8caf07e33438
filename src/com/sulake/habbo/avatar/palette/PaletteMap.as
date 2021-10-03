package com.sulake.habbo.avatar.palette
{
   import flash.utils.ByteArray;
   
   public class PaletteMap
   {
       
      
      private var map:Array;
      
      public function PaletteMap(param1:XML)
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = 0;
         super();
         map = new Array();
         for each(_loc2_ in param1.color)
         {
            _loc3_ = String(_loc2_.@value);
            _loc4_ = uint(parseInt(_loc3_,16));
            map.push(_loc4_);
         }
      }
      
      public function colorize(param1:ByteArray) : ByteArray
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc2_:ByteArray = new ByteArray();
         param1.position = 0;
         while(param1.bytesAvailable)
         {
            _loc3_ = uint(param1.readUnsignedByte());
            _loc4_ = uint(param1.readUnsignedByte());
            _loc5_ = uint(255 - param1.readUnsignedByte());
            _loc6_ = uint(param1.readUnsignedByte());
            _loc7_ = uint(map[_loc5_] as uint);
            _loc2_.writeUnsignedInt(_loc3_ << 24 | _loc7_);
         }
         _loc2_.position = 0;
         return _loc2_;
      }
   }
}
