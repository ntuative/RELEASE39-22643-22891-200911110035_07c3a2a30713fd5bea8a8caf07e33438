package com.sulake.habbo.avatar.geometry
{
   public class Node3D
   {
       
      
      private var var_1185:Vector3D;
      
      private var var_486:Vector3D;
      
      public function Node3D(param1:Number, param2:Number, param3:Number)
      {
         var_1185 = new Vector3D();
         super();
         var_486 = new Vector3D(param1,param2,param3);
      }
      
      public function get transformedLocation() : Vector3D
      {
         return var_1185;
      }
      
      public function get location() : Vector3D
      {
         return var_486;
      }
      
      public function applyTransform(param1:Matrix4x4) : void
      {
         var_1185 = param1.vectorMultiplication(var_486);
      }
   }
}
