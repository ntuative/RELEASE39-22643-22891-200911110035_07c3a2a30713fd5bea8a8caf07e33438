package com.sulake.habbo.room.object.visualization.furniture.data
{
   public class DirectionData
   {
       
      
      private var var_168:Array;
      
      public function DirectionData(param1:int)
      {
         var _loc3_:* = null;
         var_168 = [];
         super();
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            _loc3_ = new LayerData();
            var_168.push(_loc3_);
            _loc2_++;
         }
      }
      
      public function getTag(param1:int) : String
      {
         var _loc2_:LayerData = getLayer(param1);
         if(_loc2_ != null)
         {
            return _loc2_.tag;
         }
         return LayerData.const_546;
      }
      
      public function copyValues(param1:DirectionData) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(layerCount != param1.layerCount)
         {
            return;
         }
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         while(_loc4_ < layerCount)
         {
            _loc2_ = getLayer(_loc4_);
            _loc3_ = param1.getLayer(_loc4_);
            if(_loc2_)
            {
               _loc2_.copyValues(_loc3_);
            }
            _loc4_++;
         }
      }
      
      public function getAlpha(param1:int) : int
      {
         var _loc2_:LayerData = getLayer(param1);
         if(_loc2_ != null)
         {
            return _loc2_.alpha;
         }
         return LayerData.const_356;
      }
      
      public function setXOffset(param1:int, param2:int) : void
      {
         var _loc3_:LayerData = getLayer(param1);
         if(_loc3_ != null)
         {
            _loc3_.xOffset = param2;
         }
      }
      
      public function setYOffset(param1:int, param2:int) : void
      {
         var _loc3_:LayerData = getLayer(param1);
         if(_loc3_ != null)
         {
            _loc3_.yOffset = param2;
         }
      }
      
      public function setInk(param1:int, param2:int) : void
      {
         var _loc3_:LayerData = getLayer(param1);
         if(_loc3_ != null)
         {
            _loc3_.ink = param2;
         }
      }
      
      public function getInk(param1:int) : int
      {
         var _loc2_:LayerData = getLayer(param1);
         if(_loc2_ != null)
         {
            return _loc2_.ink;
         }
         return LayerData.const_517;
      }
      
      public function setIgnoreMouse(param1:int, param2:Boolean) : void
      {
         var _loc3_:LayerData = getLayer(param1);
         if(_loc3_ != null)
         {
            _loc3_.ignoreMouse = param2;
         }
      }
      
      public function setZOffset(param1:int, param2:Number) : void
      {
         var _loc3_:LayerData = getLayer(param1);
         if(_loc3_ != null)
         {
            _loc3_.zOffset = param2;
         }
      }
      
      public function getXOffset(param1:int) : int
      {
         var _loc2_:LayerData = getLayer(param1);
         if(_loc2_ != null)
         {
            return _loc2_.xOffset;
         }
         return LayerData.const_401;
      }
      
      public function getYOffset(param1:int) : int
      {
         var _loc2_:LayerData = getLayer(param1);
         if(_loc2_ != null)
         {
            return _loc2_.yOffset;
         }
         return LayerData.const_348;
      }
      
      public function getZOffset(param1:int) : Number
      {
         var _loc2_:LayerData = getLayer(param1);
         if(_loc2_ != null)
         {
            return _loc2_.zOffset;
         }
         return LayerData.const_432;
      }
      
      public function setTag(param1:int, param2:String) : void
      {
         var _loc3_:LayerData = getLayer(param1);
         if(_loc3_ != null)
         {
            _loc3_.tag = param2;
         }
      }
      
      private function getLayer(param1:int) : LayerData
      {
         if(param1 < 0 || param1 >= layerCount)
         {
            return null;
         }
         return var_168[param1];
      }
      
      public function setAlpha(param1:int, param2:int) : void
      {
         var _loc3_:LayerData = getLayer(param1);
         if(_loc3_ != null)
         {
            _loc3_.alpha = param2;
         }
      }
      
      public function getIgnoreMouse(param1:int) : Boolean
      {
         var _loc2_:LayerData = getLayer(param1);
         if(_loc2_ != null)
         {
            return _loc2_.ignoreMouse;
         }
         return LayerData.const_483;
      }
      
      public function get layerCount() : int
      {
         return var_168.length;
      }
      
      public function dispose() : void
      {
         var_168 = null;
      }
   }
}
