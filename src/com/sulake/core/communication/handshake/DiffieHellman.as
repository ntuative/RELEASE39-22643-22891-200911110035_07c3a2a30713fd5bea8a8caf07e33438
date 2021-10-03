package com.sulake.core.communication.handshake
{
   import com.hurlant.math.BigInteger;
   
   public class DiffieHellman implements IKeyExchange
   {
       
      
      private var var_1421:BigInteger;
      
      private var var_880:BigInteger;
      
      private var var_1969:BigInteger;
      
      private var var_1422:BigInteger;
      
      private var var_1970:BigInteger;
      
      private var var_1771:BigInteger;
      
      public function DiffieHellman(param1:BigInteger, param2:BigInteger)
      {
         super();
         var_1421 = param1;
         var_1969 = param2;
      }
      
      public function getSharedKey(param1:uint = 16) : String
      {
         return var_1970.toRadix(param1);
      }
      
      public function generateSharedKey(param1:String, param2:uint = 16) : String
      {
         var_1422 = new BigInteger();
         var_1422.fromRadix(param1,param2);
         var_1970 = var_1422.modPow(var_880,var_1421);
         return getSharedKey(param2);
      }
      
      public function getPublicKey(param1:uint = 16) : String
      {
         return var_1771.toRadix(param1);
      }
      
      public function init(param1:String, param2:uint = 16) : Boolean
      {
         var_880 = new BigInteger();
         var_880.fromRadix(param1,param2);
         var_1771 = var_1969.modPow(var_880,var_1421);
         return true;
      }
   }
}
