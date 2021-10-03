package com.sulake.habbo.avatar.animation
{
   public class RemoveDataContainer
   {
       
      
      private var _id:String;
      
      public function RemoveDataContainer(param1:XML)
      {
         super();
         _id = String(param1.@id);
      }
   }
}
