package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureHabboWheelVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const const_985:int = 31;
      
      private static const const_986:int = 32;
      
      private static const const_708:int = 10;
      
      private static const const_463:int = 20;
       
      
      private var var_538:Boolean = false;
      
      private var var_212:Array;
      
      public function FurnitureHabboWheelVisualization()
      {
         var_212 = new Array();
         super();
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == -1)
         {
            var_538 = true;
            var_212 = new Array();
            var_212.push(const_985);
            var_212.push(const_986);
            return;
         }
         if(param1 > 0 && param1 <= const_708)
         {
            if(var_538)
            {
               var_538 = false;
               var_212 = new Array();
               var_212.push(const_708 + param1);
               var_212.push(const_463 + param1);
               var_212.push(param1);
               return;
            }
            super.setAnimation(param1);
         }
      }
      
      override protected function updateAnimation(param1:Number) : Boolean
      {
         if(super.getLastFramePlayed(1) && super.getLastFramePlayed(2) && super.getLastFramePlayed(3))
         {
            if(false)
            {
               super.setAnimation(var_212.shift());
            }
         }
         return super.updateAnimation(param1);
      }
   }
}
