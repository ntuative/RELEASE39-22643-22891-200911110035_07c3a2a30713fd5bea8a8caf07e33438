package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class PerformanceLogMessageComposer implements IMessageComposer
   {
       
      
      private var var_918:int = 0;
      
      private var var_1174:int = 0;
      
      private var var_1863:String = "";
      
      private var var_917:int = 0;
      
      private var var_1925:String = "";
      
      private var var_1929:int = 0;
      
      private var var_1861:String = "";
      
      private var var_1926:int = 0;
      
      private var var_1928:int = 0;
      
      private var var_1862:String = "";
      
      private var var_1927:int = 0;
      
      public function PerformanceLogMessageComposer(param1:int, param2:String, param3:String, param4:String, param5:String, param6:Boolean, param7:int, param8:int, param9:int, param10:int, param11:int)
      {
         super();
         var_1926 = param1;
         var_1862 = param2;
         var_1861 = param3;
         var_1863 = param4;
         var_1925 = param5;
         if(param6)
         {
            var_1174 = 1;
         }
         else
         {
            var_1174 = 0;
         }
         var_1929 = param7;
         var_1928 = param8;
         var_917 = param9;
         var_1927 = param10;
         var_918 = param11;
      }
      
      public function getMessageArray() : Array
      {
         return [var_1926,var_1862,var_1861,var_1863,var_1925,var_1174,var_1929,var_1928,var_917,var_1927,var_918];
      }
      
      public function dispose() : void
      {
      }
   }
}
