package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureValRandomizerVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const const_985:int = 31;
      
      private static const const_986:int = 32;
      
      private static const const_464:int = 30;
      
      private static const const_708:int = 20;
      
      private static const const_463:int = 10;
       
      
      private var var_538:Boolean = false;
      
      private var var_212:Array;
      
      public function FurnitureValRandomizerVisualization()
      {
         var_212 = new Array();
         super();
         super.setAnimation(const_464);
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == 0)
         {
            var_538 = true;
            var_212 = new Array();
            var_212.push(const_985);
            var_212.push(const_986);
            return;
         }
         if(param1 > 0 && param1 <= const_463)
         {
            if(var_538)
            {
               var_538 = false;
               var_212 = new Array();
               if(_direction == 2)
               {
                  var_212.push(const_708 + 5 - param1);
                  var_212.push(const_463 + 5 - param1);
               }
               else
               {
                  var_212.push(const_708 + param1);
                  var_212.push(const_463 + param1);
               }
               var_212.push(const_464);
               return;
            }
            super.setAnimation(const_464);
         }
      }
      
      override protected function updateAnimation(param1:Number) : Boolean
      {
         if(super.getLastFramePlayed(11))
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
