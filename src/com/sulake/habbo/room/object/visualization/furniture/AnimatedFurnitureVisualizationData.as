package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.habbo.room.object.visualization.furniture.data.AnimationFrame;
   import com.sulake.habbo.room.object.visualization.furniture.data.AnimationSizeData;
   import com.sulake.habbo.room.object.visualization.furniture.data.SizeData;
   
   public class AnimatedFurnitureVisualizationData extends FurnitureVisualizationData
   {
       
      
      public function AnimatedFurnitureVisualizationData()
      {
         super();
      }
      
      public function getFrame(param1:int, param2:int, param3:int, param4:int) : AnimationFrame
      {
         var _loc5_:AnimationSizeData = getSizeData(param4) as AnimationSizeData;
         if(_loc5_ != null)
         {
            return _loc5_.getFrame(param1,param2,param3);
         }
         return null;
      }
      
      public function getFrameFromSequence(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : AnimationFrame
      {
         var _loc7_:AnimationSizeData = getSizeData(param6) as AnimationSizeData;
         if(_loc7_ != null)
         {
            return _loc7_.getFrameFromSequence(param1,param2,param3,param4,param5);
         }
         return null;
      }
      
      override protected function processVisualizationElement(param1:SizeData, param2:XML) : Boolean
      {
         var _loc3_:* = null;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         switch(String(param2.name()))
         {
            case "animations":
               _loc3_ = param1 as AnimationSizeData;
               if(_loc3_ != null)
               {
                  if(!_loc3_.defineAnimations(param2))
                  {
                     return false;
                  }
               }
               break;
            default:
               if(!super.processVisualizationElement(param1,param2))
               {
                  return false;
               }
               break;
         }
         return true;
      }
      
      override protected function createSizeData(param1:int, param2:int) : SizeData
      {
         var _loc3_:* = null;
         return new AnimationSizeData(param1,param2);
      }
   }
}
