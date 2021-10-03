package com.sulake.core.communication.util
{
   import flash.utils.ByteArray;
   
   public class Short
   {
       
      
      private var var_652:ByteArray;
      
      public function Short(param1:int)
      {
         super();
         var_652 = new ByteArray();
         var_652.writeShort(param1);
         var_652.position = 0;
      }
      
      public function get value() : int
      {
         var _loc1_:int = 0;
         var_652.position = 0;
         if(false)
         {
            _loc1_ = var_652.readShort();
            var_652.position = 0;
         }
         return _loc1_;
      }
   }
}
