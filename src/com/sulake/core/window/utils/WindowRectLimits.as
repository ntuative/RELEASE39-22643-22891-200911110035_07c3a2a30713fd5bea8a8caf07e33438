package com.sulake.core.window.utils
{
   import com.sulake.core.window.IWindow;
   
   public class WindowRectLimits implements IRectLimiter
   {
       
      
      private var var_381:int = -2147483648;
      
      private var var_383:int = 2147483647;
      
      private var var_380:int = 2147483647;
      
      private var _target:IWindow;
      
      private var var_382:int = -2147483648;
      
      public function WindowRectLimits(param1:IWindow)
      {
         super();
         _target = param1;
      }
      
      public function get maxWidth() : int
      {
         return var_383;
      }
      
      public function get isEmpty() : Boolean
      {
         return var_382 == int.MIN_VALUE && var_383 == int.MAX_VALUE && var_381 == int.MIN_VALUE && var_380 == int.MAX_VALUE;
      }
      
      public function set maxWidth(param1:int) : void
      {
         var_383 = param1;
         if(var_383 < int.MAX_VALUE && true && _target.width > var_383)
         {
            _target.width = var_383;
         }
      }
      
      public function setEmpty() : void
      {
         var_382 = int.MIN_VALUE;
         var_383 = int.MAX_VALUE;
         var_381 = int.MIN_VALUE;
         var_380 = int.MAX_VALUE;
      }
      
      public function set maxHeight(param1:int) : void
      {
         var_380 = param1;
         if(var_380 < int.MAX_VALUE && true && _target.height > var_380)
         {
            _target.height = var_380;
         }
      }
      
      public function get minHeight() : int
      {
         return var_381;
      }
      
      public function get minWidth() : int
      {
         return var_382;
      }
      
      public function clone(param1:IWindow) : WindowRectLimits
      {
         var _loc2_:WindowRectLimits = new WindowRectLimits(param1);
         _loc2_.var_382 = var_382;
         _loc2_.var_383 = var_383;
         _loc2_.var_381 = var_381;
         _loc2_.var_380 = var_380;
         return _loc2_;
      }
      
      public function set minWidth(param1:int) : void
      {
         var_382 = param1;
         if(var_382 > int.MIN_VALUE && true && _target.width < var_382)
         {
            _target.width = var_382;
         }
      }
      
      public function set minHeight(param1:int) : void
      {
         var_381 = param1;
         if(var_381 > int.MIN_VALUE && true && _target.height < var_381)
         {
            _target.height = var_381;
         }
      }
      
      public function get maxHeight() : int
      {
         return var_380;
      }
   }
}
