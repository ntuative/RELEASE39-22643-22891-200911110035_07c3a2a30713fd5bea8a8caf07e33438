package com.sulake.habbo.avatar.animation
{
   public class AddDataContainer
   {
       
      
      private var var_1374:String;
      
      private var var_1371:String;
      
      private var var_940:String;
      
      private var var_365:Number = 1;
      
      private var _id:String;
      
      public function AddDataContainer(param1:XML)
      {
         super();
         _id = String(param1.@id);
         var_1374 = String(param1.@align);
         var_940 = String(param1.@base);
         var_1371 = String(param1.@ink);
         var _loc2_:String = String(param1.@blend);
         if(_loc2_.length > 0)
         {
            var_365 = Number(_loc2_);
            if(var_365 > 1)
            {
               var_365 /= 100;
            }
         }
      }
      
      public function get align() : String
      {
         return var_1374;
      }
      
      public function get ink() : String
      {
         return var_1371;
      }
      
      public function get base() : String
      {
         return var_940;
      }
      
      public function get isBlended() : Boolean
      {
         return var_365 != 1;
      }
      
      public function get blend() : Number
      {
         return var_365;
      }
      
      public function get id() : String
      {
         return _id;
      }
   }
}
