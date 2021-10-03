package com.sulake.core.window.utils
{
   public class ChildEntityArray extends ChildEntityArrayReader implements IChildEntityArray
   {
       
      
      public function ChildEntityArray()
      {
         super();
      }
      
      public function swapChildrenAt(param1:int, param2:int) : void
      {
         this.swapChildren(var_39[param1],var_39[param2]);
      }
      
      public function removeChild(param1:IChildEntity) : IChildEntity
      {
         var _loc2_:int = var_39.indexOf(param1);
         if(_loc2_ < 0)
         {
            return null;
         }
         var_39.splice(_loc2_,1);
         return param1;
      }
      
      public function addChildAt(param1:IChildEntity, param2:int) : IChildEntity
      {
         var_39.splice(param2,0,param1);
         return param1;
      }
      
      public function swapChildren(param1:IChildEntity, param2:IChildEntity) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(param1 != null && param2 != null && param1 != param2)
         {
            _loc3_ = var_39.indexOf(param1);
            if(_loc3_ < 0)
            {
               return;
            }
            _loc4_ = var_39.indexOf(param2);
            if(_loc4_ < 0)
            {
               return;
            }
            if(_loc4_ < _loc3_)
            {
               _loc5_ = param1;
               param1 = param2;
               param2 = _loc5_;
               _loc6_ = _loc3_;
               _loc3_ = _loc4_;
               _loc4_ = _loc6_;
            }
            var_39.splice(_loc4_,1);
            var_39.splice(_loc3_,1);
            var_39[_loc3_] = param2;
            var_39[_loc4_] = param1;
         }
      }
      
      public function removeChildAt(param1:int) : IChildEntity
      {
         var _loc2_:IChildEntity = var_39[param1];
         if(_loc2_ != null)
         {
            var_39.splice(param1,1);
            return _loc2_;
         }
         return null;
      }
      
      public function addChild(param1:IChildEntity) : IChildEntity
      {
         var_39.push(param1);
         return param1;
      }
      
      public function setChildIndex(param1:IChildEntity, param2:int) : void
      {
         var _loc3_:int = var_39.indexOf(param1);
         if(_loc3_ > -1 && param2 != _loc3_)
         {
            var_39.splice(_loc3_,1);
            var_39[param2] = param1;
         }
      }
   }
}
