package com.sulake.habbo.localization
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.TextAsset;
   import com.sulake.core.localization.CoreLocalizationManager;
   import com.sulake.core.localization.enum.LocalizationEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.CoreComponent;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.configuration.enum.HabboConfigurationEvent;
   import com.sulake.habbo.localization.enum.LocalizationEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import iid.IIDHabboWindowManager;
   
   public class HabboLocalizationManager extends CoreLocalizationManager implements IHabboLocalizationManager
   {
      
      private static var var_1238:String = "%";
       
      
      private var var_160:IHabboConfigurationManager;
      
      private var _windowManager:IHabboWindowManager;
      
      public function HabboLocalizationManager(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
         if(param1 is CoreComponent)
         {
            (param1 as CoreComponent).events.addEventListener(Component.COMPONENT_EVENT_RUNNING,onComponentsRunning);
         }
         queueInterface(new IIDHabboConfigurationManager(),onHabboConfigurationInit);
         queueInterface(new IIDHabboWindowManager(),onWindowManagerReady);
         var _loc4_:TextAsset = _assets.getAssetByName("default_localization") as TextAsset;
         parseLocalizationData(_loc4_.content.toString());
         this.events.addEventListener(com.sulake.core.localization.enum.LocalizationEvent.const_10,onLocalizationLoaded);
      }
      
      private function onWindowManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _windowManager = IHabboWindowManager(param2);
      }
      
      private function fillParams(param1:String, param2:Dictionary) : String
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc3_:int = 0;
         while(_loc3_ < 10)
         {
            _loc4_ = param1.indexOf(var_1238);
            if(_loc4_ < 0)
            {
               break;
            }
            _loc5_ = param1.indexOf(var_1238,_loc4_ + 1);
            if(_loc5_ < 0)
            {
               break;
            }
            _loc6_ = param1.substring(_loc4_ + 1,_loc5_);
            _loc7_ = param2[_loc6_];
            param1 = param1.replace("%" + _loc6_ + "%",_loc7_);
            _loc3_++;
         }
         return param1;
      }
      
      private function onComponentsRunning(param1:Event = null) : void
      {
      }
      
      private function onConfigurationReady(param1:Event = null) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc2_:String = "";
         _loc2_ = var_160.getKey("url.prefix",_loc2_);
         _loc2_ = _loc2_.replace("http://","");
         _loc2_ = _loc2_.replace("https://","");
         super.setPredefinedUrl(_loc2_);
         if("IssueListView" == var_160.getKey("use.default.localizations","IssueListView"))
         {
            _loc4_ = var_160.getKey("external.texts.txt","external_texts.txt");
            super.loadLocalizationFromURL(_loc4_);
         }
         var _loc3_:int = 1;
         while(var_160.keyExists("localization." + _loc3_))
         {
            _loc5_ = var_160.getKey("localization." + _loc3_,"");
            _loc6_ = var_160.getKey("localization." + _loc3_ + ".name","");
            _loc7_ = var_160.getKey("localization." + _loc3_ + ".url","");
            super.registerLocalizationDefinition(_loc5_,_loc6_,_loc7_);
            _loc3_++;
         }
      }
      
      private function checkDefaultKeys() : void
      {
         var _loc6_:* = null;
         var _loc1_:TextAsset = _assets.getAssetByName("keys_in_use") as TextAsset;
         var _loc2_:String = _loc1_.content.toString();
         var _loc3_:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/mg;
         var _loc4_:RegExp = /^\s+|\s+$/g;
         var _loc5_:Array = _loc2_.split(_loc3_);
         for each(_loc6_ in _loc5_)
         {
            if(_loc6_.substr(0,1) != "#")
            {
               if(_loc6_.length != 0)
               {
                  if(getLocalization(_loc6_) == null)
                  {
                     Logger.log(_loc6_);
                  }
               }
            }
         }
      }
      
      private function onHabboConfigurationInit(param1:IID = null, param2:IUnknown = null) : void
      {
         if(param2 != null)
         {
            var_160 = param2 as IHabboConfigurationManager;
            (var_160 as Component).events.addEventListener(HabboConfigurationEvent.INIT,onConfigurationReady);
         }
      }
      
      private function showKeys(param1:IAlertDialog, param2:Event) : void
      {
         param1.dispose();
         printNonExistingKeys();
      }
      
      public function getKeyWithParams(param1:String, param2:Dictionary = null, param3:String = "") : String
      {
         var _loc4_:String = getKey(param1);
         if(param2 != null)
         {
            _loc4_ = fillParams(_loc4_,param2);
         }
         return _loc4_;
      }
      
      private function onLocalizationLoaded(param1:Event) : void
      {
         events.dispatchEvent(new Event(com.sulake.habbo.localization.enum.LocalizationEvent.const_10));
      }
   }
}
