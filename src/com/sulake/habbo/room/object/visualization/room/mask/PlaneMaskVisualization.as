package com.sulake.habbo.room.object.visualization.room.mask
{
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IVector3d;
   
   public class PlaneMaskVisualization
   {
      
      public static const const_47:Number = -1;
      
      public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;
       
      
      private var var_402:Array;
      
      public function PlaneMaskVisualization()
      {
         var_402 = [];
         super();
      }
      
      public function addBitmap(param1:IGraphicAsset, param2:Number = -1, param3:Number = 1, param4:Number = -1, param5:Number = 1) : void
      {
         var _loc6_:PlaneMaskBitmap = new PlaneMaskBitmap(param1,param2,param3,param4,param5);
         var_402.push(_loc6_);
      }
      
      public function getAsset(param1:IVector3d) : IGraphicAsset
      {
         var _loc3_:* = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:int = 0;
         while(_loc2_ < var_402.length)
         {
            _loc3_ = var_402[_loc2_] as PlaneMaskBitmap;
            if(_loc3_ != null)
            {
               if(param1.x >= _loc3_.normalMinX && param1.x <= _loc3_.normalMaxX && param1.y >= _loc3_.normalMinY && param1.y <= _loc3_.normalMaxY)
               {
                  return _loc3_.asset;
               }
            }
            _loc2_++;
         }
         return null;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(var_402 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_402.length)
            {
               _loc2_ = var_402[_loc1_] as PlaneMaskBitmap;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            var_402 = null;
         }
      }
   }
}
