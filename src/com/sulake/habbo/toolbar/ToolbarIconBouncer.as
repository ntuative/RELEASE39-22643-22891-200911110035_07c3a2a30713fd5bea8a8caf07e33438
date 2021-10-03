package com.sulake.habbo.toolbar
{
   public class ToolbarIconBouncer
   {
       
      
      private var var_1609:Number;
      
      private var var_486:Number = 0;
      
      private var var_1608:Number;
      
      private var var_485:Number;
      
      public function ToolbarIconBouncer(param1:Number, param2:Number)
      {
         super();
         var_1609 = param1;
         var_1608 = param2;
      }
      
      public function update() : void
      {
         var_485 += var_1608;
         var_486 += var_485;
         if(var_486 > 0)
         {
            var_486 = 0;
            var_485 = var_1609 * -1 * var_485;
         }
      }
      
      public function reset(param1:int) : void
      {
         var_485 = param1;
         var_486 = 0;
      }
      
      public function get location() : Number
      {
         return var_486;
      }
   }
}
