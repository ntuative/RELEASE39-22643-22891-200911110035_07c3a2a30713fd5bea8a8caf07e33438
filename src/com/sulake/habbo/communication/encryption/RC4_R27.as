package com.sulake.habbo.communication.encryption
{
   import com.sulake.core.communication.encryption.CryptoTools;
   import com.sulake.core.communication.encryption.IEncryption;
   import com.sulake.core.communication.encryption.RC4;
   import flash.utils.ByteArray;
   
   public class RC4_R27 extends RC4 implements IEncryption
   {
      
      private static const const_984:int = 52;
      
      private static const WEDGIE_BYTE_MASK:uint = 64;
      
      private static const const_983:String = "mWxFRJnGJ5T9Si0OMVvEBBm8laihXkN8GmH6fuv7ldZhLyGRRKCcGzziPYBaJom";
      
      private static const PREMIX_STRING:String = "NV6VVFPoC7FLDlzDUri3qcOAg9cRoFOmsYR9ffDGy5P8HfF6eekX40SFSVfJ1mDb3lcpYRqdg28sp61eHkPukKbqTu1JsVEKiRavi04YtSzUsLXaYSa5BEGwg5G2OF";
      
      private static const const_715:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
       
      
      private var var_1640:PseudoRandom;
      
      private var var_1312:IEncryption;
      
      public function RC4_R27(param1:IEncryption, param2:PseudoRandom)
      {
         super();
         var_1312 = param1;
         var_1640 = param2;
      }
      
      public static function getDecodedSize(param1:int) : int
      {
         var _loc2_:int = param1 % 4;
         switch(_loc2_)
         {
            case 0:
               return param1 / 4 * 3;
            case 2:
               return (param1 - 2) / 4 * 3 + 1;
            case 3:
               return (param1 - 3) / 4 * 3 + 2;
            default:
               return 0;
         }
      }
      
      public static function getEncodedSize(param1:int) : int
      {
         var _loc2_:int = param1 % 3;
         switch(_loc2_)
         {
            case 0:
               return param1 / 3 * 4;
            case 1:
               return (param1 - 1) / 3 * 4 + 2;
            case 2:
               return (param1 - 2) / 3 * 4 + 3;
            default:
               return 0;
         }
      }
      
      override public function init(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = CryptoTools.stringToByteArray(const_983);
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            param1[_loc4_] ^= _loc3_[_loc2_];
            _loc2_ = _loc2_ >= _loc3_.length - 1 ? 0 : int(_loc2_ + 1);
            _loc4_++;
         }
         super.init(param1);
         var _loc5_:ByteArray = CryptoTools.stringToByteArray(PREMIX_STRING);
         var _loc6_:int = 0;
         while(_loc6_ < const_984)
         {
            super.encipher(_loc5_,true);
            _loc6_++;
         }
      }
      
      override public function encipher(param1:ByteArray, param2:Boolean = false) : ByteArray
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         if(var_1312 != null)
         {
            _loc7_ = new ByteArray();
            _loc8_ = new ByteArray();
            _loc6_ = var_1640.nextInt() % 5;
            _loc9_ = param1.length - 3;
            _loc10_ = _loc6_ + _loc9_;
            _loc11_ = RC4_R27.getEncodedSize(_loc10_);
            _loc7_.writeByte(Math.floor(Math.random() * 255));
            _loc7_.writeByte(WEDGIE_BYTE_MASK | _loc11_ >> 12 & 63);
            _loc7_.writeByte(WEDGIE_BYTE_MASK | _loc11_ >> 6 & 63);
            _loc7_.writeByte(WEDGIE_BYTE_MASK | 63 & _loc11_);
            _loc5_ = var_1312.encipher(_loc7_,true);
            while(_loc8_.length < _loc6_)
            {
               _loc8_.writeByte(Math.floor(Math.random() * 255));
            }
            _loc8_.position = _loc6_;
            _loc8_.writeBytes(param1,3);
            _loc3_ = super.encipher(_loc8_,true);
            _loc4_ = Base64.encodeBytes(_loc3_,0,false);
            _loc5_.position = _loc5_.length;
            _loc5_.writeBytes(CryptoTools.stringToByteArray(_loc4_));
         }
         else
         {
            _loc3_ = super.encipher(param1,true);
            _loc4_ = Base64.encodeBytes(_loc3_,0,false);
            _loc5_ = CryptoTools.stringToByteArray(_loc4_);
         }
         return _loc5_;
      }
      
      override protected function customHackScramble(param1:Array, param2:int, param3:int) : void
      {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         if((param2 & 63) == 63)
         {
            _loc4_ = (param2 + 67) * 297 & 255;
            _loc5_ = param3 + param1[_loc4_] & 255;
            _loc6_ = param1[_loc4_];
            param1[_loc4_] = param1[_loc5_];
            param1[_loc5_] = _loc6_;
         }
      }
   }
}
