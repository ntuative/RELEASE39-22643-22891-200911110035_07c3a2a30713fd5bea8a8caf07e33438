package com.sulake.habbo.avatar.geometry
{
   import flash.utils.Dictionary;
   
   public class GeometryBodyPart extends Node3D
   {
       
      
      private var var_492:Dictionary;
      
      private var var_1172:Number;
      
      private var _id:String;
      
      public function GeometryBodyPart(param1:XML)
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         super(parseFloat(param1.@x),parseFloat(param1.@y),parseFloat(param1.@z));
         var_1172 = parseFloat(param1.@radius);
         _id = String(param1.@id);
         var_492 = new Dictionary();
         for each(_loc2_ in param1..item)
         {
            _loc3_ = new GeometryItem(_loc2_);
            var_492[String(_loc2_.@id)] = _loc3_;
         }
      }
      
      public function removeDynamicParts() : Boolean
      {
         var _loc1_:* = null;
         for each(_loc1_ in var_492)
         {
            if(_loc1_ != null)
            {
               if(_loc1_.isDynamic)
               {
                  var_492[_loc1_.id] = null;
                  _loc1_ = null;
               }
            }
         }
         return true;
      }
      
      public function getParts(param1:Matrix4x4, param2:Vector3D, param3:Array) : Array
      {
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc8_:Number = NaN;
         var _loc5_:Array = new Array();
         var _loc6_:Array = new Array();
         for each(_loc4_ in var_492)
         {
            if(_loc4_ != null)
            {
               if(param3.indexOf(_loc4_.id) == -1)
               {
               }
               _loc4_.applyTransform(param1);
               _loc8_ = _loc4_.getDistance(param2);
               _loc5_.push([_loc8_,_loc4_]);
            }
         }
         _loc5_.sort(orderParts);
         for each(_loc7_ in _loc5_)
         {
            _loc4_ = _loc7_[1] as GeometryItem;
            _loc6_.push(_loc4_.id);
         }
         return _loc6_;
      }
      
      public function getDistance(param1:Vector3D) : Number
      {
         var _loc2_:Number = Math.abs(param1.z - this.transformedLocation.z - var_1172);
         var _loc3_:Number = Math.abs(param1.z - this.transformedLocation.z + var_1172);
         return Math.min(_loc2_,_loc3_);
      }
      
      public function hasPart(param1:String) : Boolean
      {
         var _loc2_:GeometryItem = var_492[param1];
         return _loc2_ != null;
      }
      
      private function orderParts(param1:Array, param2:Array) : Number
      {
         var _loc3_:Number = param1[0] as Number;
         var _loc4_:Number = param2[0] as Number;
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return 0;
      }
      
      public function getDynamicParts() : Array
      {
         var _loc2_:* = null;
         var _loc1_:* = [];
         for each(_loc2_ in var_492)
         {
            if(_loc2_ != null)
            {
               if(_loc2_.isDynamic)
               {
                  _loc1_.push(_loc2_);
               }
            }
         }
         return _loc1_;
      }
      
      public function get radius() : Number
      {
         return var_1172;
      }
      
      public function addPart(param1:XML) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:String = String(param1.@id);
         if(!hasPart(_loc2_))
         {
            _loc3_ = new GeometryItem(param1,true);
            var_492[_loc2_] = _loc3_;
            return true;
         }
         return false;
      }
      
      public function get id() : String
      {
         return _id;
      }
   }
}
