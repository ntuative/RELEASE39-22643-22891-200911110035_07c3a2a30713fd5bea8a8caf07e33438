package com.sulake.core.localization
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.Map;
   
   public interface ICoreLocalizationManager extends IUnknown
   {
       
      
      function getLocalizationDefinition(param1:String) : ILocalizationDefinition;
      
      function loadLocalizationFromURL(param1:String) : void;
      
      function getActiveLocalizationDefinition() : ILocalizationDefinition;
      
      function getKey(param1:String, param2:String = "") : String;
      
      function getKeys() : Array;
      
      function activateLocalization(param1:String) : Boolean;
      
      function registerParameter(param1:String, param2:String, param3:String, param4:String = "%") : String;
      
      function registerLocalizationDefinition(param1:String, param2:String, param3:String) : void;
      
      function getLocalizationDefinitions() : Map;
      
      function updateKey(param1:String, param2:String) : void;
      
      function registerListener(param1:String, param2:ILocalizable) : Boolean;
      
      function removeListener(param1:String, param2:ILocalizable) : Boolean;
      
      function getLocalization(param1:String) : ILocalization;
      
      function printNonExistingKeys() : void;
   }
}
