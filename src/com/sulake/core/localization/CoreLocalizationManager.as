package com.sulake.core.localization
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.localization.enum.LocalizationEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.utils.Map;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class CoreLocalizationManager extends Component implements ICoreLocalizationManager
   {
       
      
      private var var_1149:Array;
      
      private var var_1398:String = "";
      
      private var var_1896:String;
      
      private var _localizationDefinitions:Map;
      
      private var _localizations:Dictionary;
      
      public function CoreLocalizationManager(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         var_1149 = [];
         super(param1,param2,param3);
         _localizations = new Dictionary();
         _localizationDefinitions = new Map();
      }
      
      public function loadLocalizationFromURL(param1:String) : void
      {
         var _loc2_:String = param1;
         if(assets.hasAsset(_loc2_))
         {
            Logger.log("[CoreLocalizationManager] reload localization for url: " + param1);
         }
         var _loc3_:URLRequest = new URLRequest(param1);
         var _loc4_:AssetLoaderStruct = assets.loadAssetFromFile(_loc2_,_loc3_,"text/plain");
         _loc4_.addEventListener(AssetLoaderEvent.const_30,onLocalizationReady);
      }
      
      private function updateAllListeners() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in _localizations)
         {
            _loc1_.updateListeners();
         }
      }
      
      protected function setPredefinedUrl(param1:String) : void
      {
         var _loc2_:* = null;
         var_1398 = param1;
         for each(_loc2_ in _localizations)
         {
            if(_loc2_.raw.indexOf("%predefined%") >= 0)
            {
               _loc2_.registerParameter("predefined",var_1398);
            }
         }
      }
      
      public function registerLocalizationDefinition(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:LocalizationDefinition = _localizationDefinitions[param1];
         if(_loc4_ == null)
         {
            _loc4_ = new LocalizationDefinition(param1,param2,param3);
            _localizationDefinitions[param1] = _loc4_;
         }
      }
      
      public function registerParameter(param1:String, param2:String, param3:String, param4:String = "%") : String
      {
         var _loc5_:Localization = _localizations[param1];
         if(_loc5_ == null)
         {
            _loc5_ = new Localization(param1);
            _localizations[param1] = _loc5_;
         }
         _loc5_.registerParameter(param2,param3,param4);
         return _loc5_.value;
      }
      
      public function removeListener(param1:String, param2:ILocalizable) : Boolean
      {
         var _loc3_:Localization = _localizations[param1];
         if(_loc3_ != null)
         {
            _loc3_.removeListener(param2);
         }
         return true;
      }
      
      public function getLocalizationDefinition(param1:String) : ILocalizationDefinition
      {
         return _localizationDefinitions[param1] as ILocalizationDefinition;
      }
      
      public function updateKey(param1:String, param2:String) : void
      {
         var _loc3_:Localization = _localizations[param1];
         if(_loc3_ == null)
         {
            _loc3_ = new Localization(param1,param2);
            _localizations[param1] = _loc3_;
         }
         else
         {
            _loc3_.setValue(param2);
         }
         if(param2.indexOf("%predefined%") >= 0)
         {
            _loc3_.registerParameter("predefined",var_1398);
         }
      }
      
      public function printNonExistingKeys() : void
      {
         var _loc2_:* = null;
         var _loc1_:String = "";
         for each(_loc2_ in var_1149)
         {
            _loc1_ += _loc2_ + "\n";
         }
         Logger.log(_loc1_);
      }
      
      public function getLocalization(param1:String) : ILocalization
      {
         return _localizations[param1] as ILocalization;
      }
      
      public function getKey(param1:String, param2:String = "") : String
      {
         var _loc3_:Localization = _localizations[param1] as Localization;
         if(_loc3_ == null)
         {
            var_1149.push(param1);
            return param2;
         }
         return _loc3_.value;
      }
      
      public function getKeys() : Array
      {
         var _loc2_:* = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in _localizations)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      private function onLocalizationReady(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.assetName;
            parseLocalizationData(_loc2_.assetLoader.content as String);
            this.events.dispatchEvent(new Event(LocalizationEvent.const_10));
         }
      }
      
      public function activateLocalization(param1:String) : Boolean
      {
         var _loc2_:LocalizationDefinition = _localizationDefinitions[param1];
         if(_loc2_ != null)
         {
            var_1896 = param1;
            loadLocalizationFromURL(_loc2_.url);
            return true;
         }
         return false;
      }
      
      public function getActiveLocalizationDefinition() : ILocalizationDefinition
      {
         return getLocalizationDefinition(var_1896);
      }
      
      public function getLocalizationDefinitions() : Map
      {
         return _localizationDefinitions;
      }
      
      protected function parseLocalizationData(param1:String) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc2_:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/mg;
         var _loc3_:RegExp = /^\s+|\s+$/g;
         var _loc4_:Array = param1.split(_loc2_);
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.substr(0,1) != "#")
            {
               _loc6_ = _loc5_.split("=");
               if(_loc6_[0].length > 0)
               {
                  if(_loc6_.length > 1)
                  {
                     _loc7_ = _loc6_.shift();
                     _loc8_ = _loc6_.join("=");
                     _loc7_ = _loc7_.replace(_loc3_,"");
                     _loc8_ = _loc8_.replace(_loc3_,"");
                     if(_loc8_.length > 0)
                     {
                        updateKey(_loc7_,_loc8_);
                     }
                  }
               }
            }
         }
         updateAllListeners();
      }
      
      public function registerListener(param1:String, param2:ILocalizable) : Boolean
      {
         var _loc3_:Localization = _localizations[param1];
         if(_loc3_ == null)
         {
            var_1149.push(param1);
            _loc3_ = new Localization(param1,param1);
            _localizations[param1] = _loc3_;
         }
         _loc3_.registerListener(param2);
         return true;
      }
   }
}
