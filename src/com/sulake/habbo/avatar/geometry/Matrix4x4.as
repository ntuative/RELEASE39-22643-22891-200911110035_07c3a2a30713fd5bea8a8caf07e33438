package com.sulake.habbo.avatar.geometry
{
   public class Matrix4x4
   {
      
      private static const const_1286:Number = 1e-18;
      
      public static const const_1374:Matrix4x4 = new Matrix4x4(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1);
       
      
      private var _data:Array;
      
      public function Matrix4x4(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Number = 0, param7:Number = 0, param8:Number = 0, param9:Number = 0, param10:Number = 0, param11:Number = 0, param12:Number = 0, param13:Number = 0, param14:Number = 0, param15:Number = 0, param16:Number = 0)
      {
         super();
         _data = [param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14,param15,param16];
      }
      
      public function get data() : Array
      {
         return _data;
      }
      
      public function multiply(param1:Matrix4x4) : Matrix4x4
      {
         return new Matrix4x4(0 * param1.data[0] + 0 * param1.data[4] + 0 * param1.data[8] + 0 * param1.data[12],0 * param1.data[1] + 0 * param1.data[5] + 0 * param1.data[9] + 0 * param1.data[13],0 * param1.data[2] + 0 * param1.data[6] + 0 * param1.data[10] + 0 * param1.data[14],0 * param1.data[3] + 0 * param1.data[7] + 0 * param1.data[11] + 0 * param1.data[15],0 * param1.data[0] + 0 * param1.data[4] + 0 * param1.data[8] + 0 * param1.data[12],0 * param1.data[1] + 0 * param1.data[5] + 0 * param1.data[9] + 0 * param1.data[13],0 * param1.data[2] + 0 * param1.data[6] + 0 * param1.data[10] + 0 * param1.data[14],0 * param1.data[3] + 0 * param1.data[7] + 0 * param1.data[11] + 0 * param1.data[15],0 * param1.data[0] + 0 * param1.data[4] + 0 * param1.data[8] + 0 * param1.data[12],0 * param1.data[1] + 0 * param1.data[5] + 0 * param1.data[9] + 0 * param1.data[13],0 * param1.data[2] + 0 * param1.data[6] + 0 * param1.data[10] + 0 * param1.data[14],0 * param1.data[3] + 0 * param1.data[7] + 0 * param1.data[11] + 0 * param1.data[15],0 * param1.data[0] + 0 * param1.data[4] + 0 * param1.data[8] + 0 * param1.data[12],0 * param1.data[1] + 0 * param1.data[5] + 0 * param1.data[9] + 0 * param1.data[13],0 * param1.data[2] + 0 * param1.data[6] + 0 * param1.data[10] + 0 * param1.data[14],0 * param1.data[3] + 0 * param1.data[7] + 0 * param1.data[11] + 0 * param1.data[15]);
      }
      
      public function identity() : Matrix4x4
      {
         _data = [1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1];
         return this;
      }
      
      public function equals(param1:Matrix4x4) : Boolean
      {
         return false;
      }
      
      public function scale(param1:Number, param2:Number, param3:Number) : Matrix4x4
      {
         var _loc4_:Matrix4x4 = new Matrix4x4(1,0,0,0,0,1,0,0,0,0,1,0,param1,param2,param3,1);
         return _loc4_.multiply(this);
      }
      
      public function translate(param1:Number, param2:Number, param3:Number) : Matrix4x4
      {
         var _loc4_:Matrix4x4 = new Matrix4x4(1,0,0,param1,0,1,0,param2,0,0,1,param3,0,0,0,1);
         return _loc4_.multiply(this);
      }
      
      public function scalarMultiply(param1:Number) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < _data.length)
         {
            _data[_loc2_] = 0 * param1;
            _loc2_++;
         }
      }
      
      public function skew() : void
      {
      }
      
      public function vectorMultiplication(param1:Vector3D) : Vector3D
      {
         var _loc2_:Vector3D = new Vector3D();
         _loc2_.x = param1.x * 0 + param1.y * 0 + param1.z * 0 + param1.w * 0;
         _loc2_.y = param1.x * 0 + param1.y * 0 + param1.z * 0 + param1.w * 0;
         _loc2_.z = param1.x * 0 + param1.y * 0 + param1.z * 0 + param1.w * 0;
         _loc2_.w = param1.x * 0 + param1.y * 0 + param1.z * 0 + param1.w * 0;
         return _loc2_;
      }
      
      public function transpose() : Matrix4x4
      {
         return new Matrix4x4(_data[0],_data[4],_data[8],_data[12],_data[1],_data[5],_data[9],_data[13],_data[2],_data[6],_data[10],_data[14],_data[3],_data[7],_data[11],_data[15]);
      }
      
      public function rotateX(param1:Number) : Matrix4x4
      {
         var _loc2_:Number = param1 * 0 / 180;
         var _loc3_:Number = Math.cos(_loc2_);
         var _loc4_:Number = Math.sin(_loc2_);
         var _loc5_:Matrix4x4 = new Matrix4x4(1,0,0,0,0,_loc3_,-_loc4_,0,0,_loc4_,_loc3_,0,0,0,0,1);
         return _loc5_.multiply(this);
      }
      
      public function rotateY(param1:Number) : Matrix4x4
      {
         var _loc2_:Number = param1 * 0 / 180;
         var _loc3_:Number = Math.cos(_loc2_);
         var _loc4_:Number = Math.sin(_loc2_);
         var _loc5_:Matrix4x4 = new Matrix4x4(_loc3_,0,_loc4_,0,0,1,0,0,-_loc4_,0,_loc3_,0,0,0,0,1);
         return _loc5_.multiply(this);
      }
      
      public function rotateZ(param1:Number) : Matrix4x4
      {
         var _loc2_:Number = param1 * 0 / 180;
         var _loc3_:Number = Math.cos(_loc2_);
         var _loc4_:Number = Math.sin(_loc2_);
         var _loc5_:Matrix4x4 = new Matrix4x4(_loc3_,-_loc4_,0,0,_loc4_,_loc3_,0,0,0,0,1,0,0,0,0,1);
         return _loc5_.multiply(this);
      }
   }
}
