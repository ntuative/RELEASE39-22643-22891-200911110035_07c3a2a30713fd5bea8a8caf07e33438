package com.sulake.core.communication.encryption
{
   import flash.utils.ByteArray;
   
   public class RC4 implements IEncryption
   {
       
      
      private var i:uint = 0;
      
      private var j:uint = 0;
      
      private var var_112:Array;
      
      public function RC4()
      {
         super();
         var_112 = new Array(256);
      }
      
      protected function customHackScramble(param1:Array, param2:int, param3:int) : void
      {
      }
      
      public function decipher(param1:ByteArray) : ByteArray
      {
         var _loc3_:int = 0;
         var _loc2_:ByteArray = new ByteArray();
         param1.position = 0;
         while(param1.bytesAvailable)
         {
            i = (i + 1) % 256;
            j = (j + var_112[i]) % 256;
            swap(i,j);
            _loc3_ = 0;
            _loc2_.writeByte(param1.readUnsignedByte() ^ 0);
         }
         _loc2_.position = 0;
         return _loc2_;
      }
      
      protected function swap(param1:uint, param2:uint) : void
      {
         var _loc3_:Object = var_112[param1];
         var_112[param1] = var_112[param2];
         var_112[param2] = _loc3_;
      }
      
      public function encipher(param1:ByteArray, param2:Boolean = false) : ByteArray
      {
         var _loc4_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         param1.position = 0;
         while(param1.bytesAvailable)
         {
            i = (i + 1) % 256;
            j = (j + var_112[i]) % 256;
            swap(i,j);
            if(param2)
            {
               customHackScramble(var_112,i,j);
            }
            _loc4_ = 0;
            _loc3_.writeByte(0 ^ param1.readByte());
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function initFromState(param1:IEncryption) : void
      {
         var _loc2_:RC4 = param1 as RC4;
         var_112 = _loc2_.var_112.concat();
         i = _loc2_.i;
         j = _loc2_.j;
      }
      
      public function init(param1:ByteArray) : void
      {
         var _loc2_:uint = param1.length;
         i = 0;
         while(i < 256)
         {
            var_112[i] = i;
            ++i;
         }
         j = 0;
         i = 0;
         while(i < 256)
         {
            j = (j + var_112[i] + param1[i % _loc2_]) % 256;
            swap(i,j);
            ++i;
         }
         i = 0;
         j = 0;
      }
   }
}
