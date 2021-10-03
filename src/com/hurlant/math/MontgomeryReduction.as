package com.hurlant.math
{
   use namespace bi_internal;
   
   class MontgomeryReduction implements IReduction
   {
       
      
      private var var_1307:int;
      
      private var var_1632:int;
      
      private var var_1308:int;
      
      private var var_1631:int;
      
      private var m:BigInteger;
      
      private var var_1633:int;
      
      function MontgomeryReduction(param1:BigInteger)
      {
         super();
         this.m = param1;
         var_1307 = param1.invDigit();
         var_1308 = var_1307 & 32767;
         var_1632 = var_1307 >> 15;
         var_1633 = 131071;
         var_1631 = 2 * param1.t;
      }
      
      public function convert(param1:BigInteger) : BigInteger
      {
         var _loc2_:BigInteger = new BigInteger();
         param1.abs().dlShiftTo(m.t,_loc2_);
         _loc2_.divRemTo(m,null,_loc2_);
         if(param1.s < 0 && _loc2_.compareTo(BigInteger.const_128) > 0)
         {
            m.subTo(_loc2_,_loc2_);
         }
         return _loc2_;
      }
      
      public function revert(param1:BigInteger) : BigInteger
      {
         var _loc2_:BigInteger = new BigInteger();
         param1.copyTo(_loc2_);
         reduce(_loc2_);
         return _loc2_;
      }
      
      public function sqrTo(param1:BigInteger, param2:BigInteger) : void
      {
         param1.squareTo(param2);
         reduce(param2);
      }
      
      public function reduce(param1:BigInteger) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Deobfuscation is activated but decompilation still failed. If the file is NOT obfuscated, disable "Automatic deobfuscation" for better results.
          * Error type: NullPointerException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function mulTo(param1:BigInteger, param2:BigInteger, param3:BigInteger) : void
      {
         param1.multiplyTo(param2,param3);
         reduce(param3);
      }
   }
}
