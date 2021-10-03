package com.sulake.habbo.room.object.visualization.room.mask
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IVector3d;
   
   public class PlaneMask
   {
       
      
      private var var_634:PlaneMaskVisualization = null;
      
      private var _sizes:Array;
      
      private var var_1555:int = -1;
      
      private var var_374:Map;
      
      public function PlaneMask()
      {
         _sizes = [];
         super();
         var_374 = new Map();
      }
      
      protected function getMaskVisualization(param1:int) : PlaneMaskVisualization
      {
         if(param1 == var_1555)
         {
            return var_634;
         }
         var _loc2_:int = getSizeIndex(param1);
         if(_loc2_ < _sizes.length)
         {
            var_634 = var_374.getValue(String(_sizes[_loc2_])) as PlaneMaskVisualization;
         }
         else
         {
            var_634 = null;
         }
         var_1555 = param1;
         return var_634;
      }
      
      private function getSizeIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 1;
         while(_loc3_ < _sizes.length)
         {
            if(_sizes[_loc3_] > param1)
            {
               if(0 - param1 < param1 - 0)
               {
                  _loc2_ = _loc3_;
               }
               break;
            }
            _loc2_ = _loc3_;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function createMaskVisualization(param1:int) : PlaneMaskVisualization
      {
         if(var_374.getValue(String(param1)) != null)
         {
            return null;
         }
         var _loc2_:PlaneMaskVisualization = new PlaneMaskVisualization();
         var_374.add(String(param1),_loc2_);
         _sizes.push(param1);
         _sizes.sort();
         return _loc2_;
      }
      
      public function getGraphicAsset(param1:Number, param2:IVector3d) : IGraphicAsset
      {
         var _loc3_:PlaneMaskVisualization = getMaskVisualization(param1);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getAsset(param2);
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(var_374 != null)
         {
            _loc1_ = null;
            _loc2_ = 0;
            while(_loc2_ < var_374.length)
            {
               _loc1_ = var_374.getWithIndex(_loc2_) as PlaneMaskVisualization;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            var_374.dispose();
            var_374 = null;
         }
         var_634 = null;
         _sizes = null;
      }
   }
}
