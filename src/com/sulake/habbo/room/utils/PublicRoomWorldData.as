package com.sulake.habbo.room.utils
{
   public class PublicRoomWorldData
   {
       
      
      private var var_1732:Number = 1;
      
      private var var_179:Number = 1;
      
      private var var_1869:String = "";
      
      public function PublicRoomWorldData(param1:String, param2:Number, param3:Number)
      {
         super();
         var_1869 = param1;
         var_179 = param2;
         var_1732 = param3;
      }
      
      public function get scale() : Number
      {
         return var_179;
      }
      
      public function get heightScale() : Number
      {
         return var_1732;
      }
   }
}
