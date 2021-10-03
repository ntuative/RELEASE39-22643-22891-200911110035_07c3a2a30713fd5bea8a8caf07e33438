package com.sulake.habbo.localization
{
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.runtime.IUnknown;
   import flash.utils.Dictionary;
   
   public interface IHabboLocalizationManager extends ICoreLocalizationManager, IUnknown
   {
       
      
      function getKeyWithParams(param1:String, param2:Dictionary = null, param3:String = "") : String;
   }
}
