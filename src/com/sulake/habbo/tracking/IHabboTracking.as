package com.sulake.habbo.tracking
{
   import com.sulake.core.runtime.IUnknown;
   
   public interface IHabboTracking extends IUnknown
   {
       
      
      function track(param1:String, param2:String, param3:Array = null) : void;
      
      function logError(param1:String) : void;
   }
}
