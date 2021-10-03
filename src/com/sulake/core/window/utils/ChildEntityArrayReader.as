package com.sulake.core.window.utils
{
   public class ChildEntityArrayReader implements IChildEntityArrayReader
   {
       
      
      protected var var_39:Array;
      
      public function ChildEntityArrayReader()
      {
         var_39 = new Array();
         super();
      }
      
      public function getChildByTag(param1:String) : IChildEntity
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = var_39[_loc4_];
            if(_loc3_.tags.indexOf(param1) > -1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function get numChildren() : int
      {
         return var_39.length;
      }
      
      public function groupChildrenWithID(param1:uint, param2:Array) : uint
      {
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = var_39[_loc6_];
            if(_loc3_.id == param1)
            {
               param2.push(_loc3_);
               _loc4_++;
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public function getChildByName(param1:String) : IChildEntity
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = var_39[_loc4_];
            if(_loc3_.name == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getChildIndex(param1:IChildEntity) : int
      {
         return var_39.indexOf(param1);
      }
      
      public function groupChildrenWithTag(param1:String, param2:Array) : uint
      {
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = var_39[_loc6_];
            if(_loc3_.tags.indexOf(param1) > -1)
            {
               param2.push(_loc3_);
               _loc4_++;
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public function getChildByID(param1:uint) : IChildEntity
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = var_39[_loc4_];
            if(_loc3_.id == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getChildAt(param1:int) : IChildEntity
      {
         return var_39[param1];
      }
   }
}
