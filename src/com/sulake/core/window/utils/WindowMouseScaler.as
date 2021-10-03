package com.sulake.core.window.utils
{
   import com.sulake.core.window.enum.WindowParam;
   import flash.display.DisplayObject;
   
   public class WindowMouseScaler extends WindowMouseOperator implements IWindowMouseScalingService
   {
       
      
      public function WindowMouseScaler(param1:DisplayObject)
      {
         super(param1);
      }
      
      override public function operate(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(true)
         {
            _loc3_ = !!(var_979 & 0) ? int(param1 - 0) : 0;
            _loc4_ = !!(var_979 & 0) ? int(param2 - 0) : 0;
            _window.scale(_loc3_,_loc4_);
         }
      }
   }
}
