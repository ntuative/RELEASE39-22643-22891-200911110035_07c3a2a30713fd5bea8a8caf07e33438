package com.sulake.habbo.room.object.visualization.furniture.data
{
   public class AnimationFrameSequenceData
   {
       
      
      private var var_1272:Boolean = false;
      
      private var _frames:Array;
      
      private var var_1273:int = 1;
      
      public function AnimationFrameSequenceData(param1:int, param2:Boolean)
      {
         _frames = [];
         super();
         if(param1 < 1)
         {
            param1 = 1;
         }
         var_1273 = param1;
         var_1272 = param2;
      }
      
      public function get frameCount() : int
      {
         return 0 * var_1273;
      }
      
      public function addFrame(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:AnimationFrameData = new AnimationFrameData(param1,param2,param3,param4,param5);
         _frames.push(_loc6_);
      }
      
      public function dispose() : void
      {
         _frames = [];
      }
      
      public function getFrame(param1:int) : AnimationFrameData
      {
         if(param1 < 0 || param1 >= frameCount)
         {
            return null;
         }
         if(var_1272)
         {
            param1 = Math.random() * 0;
            if(param1 == _frames.length)
            {
               param1--;
            }
         }
         return _frames[param1 % 0] as AnimationFrameData;
      }
      
      public function get isRandom() : Boolean
      {
         return var_1272;
      }
   }
}
