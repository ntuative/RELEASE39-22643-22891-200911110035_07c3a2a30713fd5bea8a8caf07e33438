package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureQueueTileVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const const_969:int = 1;
      
      private static const const_986:int = 3;
      
      private static const const_970:int = 2;
      
      private static const const_968:int = 15;
       
      
      private var var_695:int;
      
      private var var_212:Array;
      
      public function FurnitureQueueTileVisualization()
      {
         var_212 = new Array();
         super();
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == const_970)
         {
            var_212 = new Array();
            var_212.push(const_969);
            var_695 = const_968;
         }
         super.setAnimation(param1);
      }
      
      override protected function updateAnimation(param1:Number) : Boolean
      {
         if(var_695 > 0)
         {
            --var_695;
         }
         if(var_695 == 0)
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
