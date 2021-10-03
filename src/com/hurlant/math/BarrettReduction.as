package com.hurlant.math
{
   use namespace bi_internal;
   
   class BarrettReduction implements IReduction
   {
       
      
      private var r2:BigInteger;
      
      private var q3:BigInteger;
      
      private var var_2024:BigInteger;
      
      private var m:BigInteger;
      
      function BarrettReduction(param1:BigInteger)
      {
         super();
         r2 = new BigInteger();
         q3 = new BigInteger();
         BigInteger.const_117.dlShiftTo(2 * param1.t,r2);
         var_2024 = r2.divide(param1);
         this.m = param1;
      }
      
      public function revert(param1:BigInteger) : BigInteger
      {
         return param1;
      }
      
      public function sqrTo(param1:BigInteger, param2:BigInteger) : void
      {
         param1.squareTo(param2);
         reduce(param2);
      }
      
      public function convert(param1:BigInteger) : BigInteger
      {
         var _loc2_:* = null;
         if(param1.s < 0 || param1.t > 0)
         {
            return param1.mod(m);
         }
         if(param1.compareTo(m) < 0)
         {
            return param1;
         }
         _loc2_ = new BigInteger();
         param1.copyTo(_loc2_);
         reduce(_loc2_);
         return _loc2_;
      }
      
      public function reduce(param1:BigInteger) : void
      {
         var _loc2_:BigInteger = param1 as BigInteger;
         _loc2_.drShiftTo(-1,r2);
         if(_loc2_.t > NaN)
         {
            _loc2_.t = NaN;
            _loc2_.clamp();
         }
         var_2024.multiplyUpperTo(r2,NaN,q3);
         m.multiplyLowerTo(q3,NaN,r2);
         while(_loc2_.compareTo(r2) < 0)
         {
            _loc2_.dAddOffset(1,NaN);
         }
         _loc2_.subTo(r2,_loc2_);
         while(_loc2_.compareTo(m) >= 0)
         {
            _loc2_.subTo(m,_loc2_);
         }
      }
      
      public function mulTo(param1:BigInteger, param2:BigInteger, param3:BigInteger) : void
      {
         param1.multiplyTo(param2,param3);
         reduce(param3);
      }
   }
}
