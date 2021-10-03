package com.sulake.habbo.communication.encryption
{
   import flash.utils.ByteArray;
   
   public class Base64
   {
      
      public static const const_911:uint = 76;
      
      private static const const_715:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
       
      
      public function Base64()
      {
         super();
      }
      
      public static function encodeBytes(param1:ByteArray, param2:uint = 76, param3:Boolean = true) : String
      {
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:int = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:int = 0;
         var _loc14_:* = null;
         param2 = Math.min(param2,const_911);
         var _loc4_:* = "";
         param1.position = 0;
         while(param1.bytesAvailable)
         {
            _loc5_ = 0;
            _loc6_ = 16;
            _loc7_ = 0;
            _loc8_ = 0;
            while(_loc8_ < 3)
            {
               if(param1.bytesAvailable)
               {
                  _loc11_ = uint(param1.readUnsignedByte());
                  _loc5_ += _loc11_ << _loc6_;
               }
               else
               {
                  _loc7_++;
               }
               _loc6_ -= 8;
               _loc8_++;
            }
            _loc6_ = 18;
            _loc9_ = uint(4 - _loc7_);
            _loc10_ = 0;
            while(_loc10_ < _loc9_)
            {
               _loc12_ = uint(_loc5_ >> _loc6_ & 63);
               _loc4_ += const_715.charAt(_loc12_);
               _loc6_ -= 6;
               _loc10_++;
            }
            if(_loc7_ > 0 && param3)
            {
               _loc13_ = 0;
               while(_loc13_ < _loc7_)
               {
                  _loc4_ += "=";
                  _loc13_++;
               }
            }
         }
         if(param2 > 0)
         {
            _loc14_ = _loc4_;
            _loc4_ = "";
            while(_loc14_.length > param2)
            {
               _loc4_ += _loc14_.substr(0,param2) + "\n";
               _loc14_ = _loc14_.substr(param2);
            }
            if(_loc14_.length > 0)
            {
               _loc4_ += _loc14_;
            }
         }
         return _loc4_;
      }
      
      public static function encode(param1:String, param2:uint = 76, param3:Boolean = true) : String
      {
         param2 = Math.min(param2,const_911);
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeMultiByte(param1,"iso-8859-1");
         _loc5_.position = 0;
         return encodeBytes(_loc5_,param2,param3);
      }
      
      public static function decode(param1:String) : String
      {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:* = null;
         var _loc11_:int = 0;
         var _loc12_:* = 0;
         param1 = param1.replace(/\s/g,"");
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = 0;
            _loc5_ = 18;
            _loc6_ = 0;
            _loc7_ = 0;
            while(_loc7_ < 4)
            {
               _loc9_ = uint(_loc3_ + _loc7_);
               _loc10_ = param1.charAt(_loc9_);
               _loc11_ = const_715.indexOf(_loc10_);
               if(_loc11_ > -1)
               {
                  _loc4_ += _loc11_ << _loc5_;
               }
               else
               {
                  _loc6_++;
               }
               _loc5_ -= 6;
               _loc7_++;
            }
            _loc5_ = 16;
            _loc8_ = 0;
            while(_loc8_ < 3 - _loc6_)
            {
               _loc12_ = uint(_loc4_ >> _loc5_ & 255);
               _loc2_ += String.fromCharCode(_loc12_);
               _loc5_ -= 8;
               _loc8_++;
            }
            _loc3_ += 3;
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
