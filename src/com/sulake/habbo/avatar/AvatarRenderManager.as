package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.CoreComponent;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IIDLogger;
   import com.sulake.core.runtime.ILogger;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.alias.AssetAliasCollection;
   import com.sulake.habbo.avatar.enum.AvatarRenderEvent;
   import com.sulake.habbo.avatar.enum.AvatarType;
   import com.sulake.habbo.avatar.palette.PaletteMap;
   import com.sulake.habbo.avatar.structure.IFigureData;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.configuration.enum.HabboConfigurationEvent;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.utils.ByteArray;
   
   public class AvatarRenderManager extends Component implements IAvatarRenderManager
   {
       
      
      private var var_192:Stage;
      
      private var var_666:CoreComponent;
      
      private var var_27:AssetAliasCollection;
      
      private var var_1320:ILogger;
      
      private var _habboConfiguration:IHabboConfigurationManager;
      
      private var var_499:Map;
      
      public function AvatarRenderManager(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         var_499 = new Map();
         super(param1,param2,param3);
         if(param1 is CoreComponent)
         {
            var_192 = CoreComponent(param1).root.stage;
            var_666 = CoreComponent(param1);
            var_666.events.addEventListener(Component.COMPONENT_EVENT_RUNNING,onComponentsRunning);
         }
         queueInterface(new IIDHabboConfigurationManager(),onHabboConfigurationReady);
         queueInterface(new IIDLogger(),receiveLoggerInterface);
      }
      
      private function onStructureInit(param1:Event = null) : void
      {
         this.events.dispatchEvent(new Event(AvatarRenderEvent.AVATAR_RENDER_READY));
      }
      
      private function onConfigurationInit(param1:Event = null) : void
      {
         var _loc2_:* = null;
         _loc2_ = var_499.getValue(AvatarType.const_118) as AvatarStructure;
         if(_loc2_ != null)
         {
            _loc2_.init(_habboConfiguration);
         }
         _loc2_ = var_499.getValue(AvatarType.PET) as AvatarStructure;
         if(_loc2_ != null)
         {
            _loc2_.init(_habboConfiguration);
         }
      }
      
      private function receiveLoggerInterface(param1:IID, param2:IUnknown) : void
      {
         var_1320 = param2 as ILogger;
      }
      
      public function out(param1:String) : void
      {
         if(var_1320 != null)
         {
            var_1320.out(param1);
         }
      }
      
      public function getFigureData(param1:String) : IFigureData
      {
         var _loc2_:AvatarStructure = var_499.getValue(param1) as AvatarStructure;
         if(_loc2_ != null)
         {
            return _loc2_.figureData;
         }
         return null;
      }
      
      public function getAssetByName(param1:String) : IAsset
      {
         return var_27.getAssetByName(param1);
      }
      
      private function onHabboConfigurationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(param2 != null)
         {
            _habboConfiguration = param2 as IHabboConfigurationManager;
            (_habboConfiguration as Component).events.addEventListener(HabboConfigurationEvent.INIT,onConfigurationInit);
         }
      }
      
      public function createPetImage(param1:String, param2:String, param3:String) : IAvatarImage
      {
         var _loc4_:AvatarStructure = var_499.getValue(AvatarType.PET) as AvatarStructure;
         if(_loc4_ == null)
         {
            return null;
         }
         return new AvatarImage(_loc4_,var_27,param1,param3,AvatarType.PET,param2);
      }
      
      private function onComponentsRunning(param1:Event = null) : void
      {
         var _loc5_:* = null;
         var _loc2_:AssetLibraryCollection = var_666.assets as AssetLibraryCollection;
         var _loc3_:int = 0;
         var _loc4_:Array = new Array();
         while(_loc2_.hasAssetLibrary("lib-" + _loc3_))
         {
            _loc4_.push("lib-" + _loc3_);
            _loc3_++;
         }
         var_27 = new AssetAliasCollection(_loc2_,_loc4_);
         _loc5_ = new AvatarStructure(assets,_loc2_,AvatarType.const_118);
         _loc5_.addEventListener(AvatarStructure.AVATAR_STRUCTURE_INIT,onStructureInit);
         var_499.add(AvatarType.const_118,_loc5_);
         _loc5_ = new AvatarStructure(assets,_loc2_,AvatarType.PET);
         _loc5_.addEventListener(AvatarStructure.AVATAR_STRUCTURE_INIT,onStructureInit);
         var_499.add(AvatarType.PET,_loc5_);
         var_27.addAlias("h_crr_ri_419_0_0","h_std_fx5_1_1_0_0");
         var_27.addAlias("h_crr_ri_419_1_0","h_std_fx5_1_1_1_0");
         var_27.addAlias("h_crr_ri_419_2_0","h_std_fx5_1_1_2_0");
         var_27.addAlias("h_crr_ri_419_3_0","h_std_fx5_1_1_3_0");
         var_27.addAlias("h_crr_ri_419_4_0","h_std_fx5_1_1_4_0");
         var_27.addAlias("h_crr_ri_419_5_0","h_std_fx5_1_1_5_0");
         var_27.addAlias("h_drk_ri_469_0_0","h_std_fx16_1_1_0_0");
         var_27.addAlias("h_drk_ri_469_1_0","h_std_fx16_1_1_1_0");
         var_27.addAlias("h_drk_ri_469_2_0","h_std_fx16_1_1_2_0");
         var_27.addAlias("h_drk_ri_469_3_0","h_std_fx16_1_1_3_0");
         var_27.addAlias("h_drk_ri_469_4_0","h_std_fx16_1_1_4_0");
         var_27.addAlias("h_drk_ri_469_5_0","h_std_fx16_1_1_5_0");
         var_27.addAlias("h_drk_ri_469_6_0","h_std_fx16_1_1_6_0");
         var_27.addAlias("h_crr_ri_470_0_0","h_std_fx26_1_1_0_0");
         var_27.addAlias("h_crr_ri_470_1_0","h_std_fx26_1_1_1_0");
         var_27.addAlias("h_crr_ri_470_2_0","h_std_fx26_1_1_2_0");
         var_27.addAlias("h_crr_ri_470_3_0","h_std_fx26_1_1_3_0");
         var_27.addAlias("h_crr_ri_470_4_0","h_std_fx26_1_1_4_0");
         var_27.addAlias("h_crr_ri_470_5_0","h_std_fx26_1_1_5_0");
         var_27.addAlias("sh_crr_ri_419_0_0","sh_std_fx5_1_1_0_0");
         var_27.addAlias("sh_crr_ri_419_1_0","sh_std_fx5_1_1_1_0");
         var_27.addAlias("sh_crr_ri_419_2_0","sh_std_fx5_1_1_2_0");
         var_27.addAlias("sh_crr_ri_419_3_0","sh_std_fx5_1_1_3_0");
         var_27.addAlias("sh_crr_ri_419_4_0","sh_std_fx5_1_1_4_0");
         var_27.addAlias("sh_crr_ri_419_5_0","sh_std_fx5_1_1_5_0");
         var_27.addAlias("sh_drk_ri_469_0_0","sh_std_fx16_1_1_0_0");
         var_27.addAlias("sh_drk_ri_469_1_0","sh_std_fx16_1_1_1_0");
         var_27.addAlias("sh_drk_ri_469_2_0","sh_std_fx16_1_1_2_0");
         var_27.addAlias("sh_drk_ri_469_3_0","sh_std_fx16_1_1_3_0");
         var_27.addAlias("sh_drk_ri_469_4_0","sh_std_fx16_1_1_4_0");
         var_27.addAlias("sh_drk_ri_469_5_0","sh_std_fx16_1_1_5_0");
         var_27.addAlias("sh_drk_ri_469_6_0","sh_std_fx16_1_1_6_0");
         var_27.addAlias("sh_crr_ri_470_0_0","sh_std_fx26_1_1_0_0");
         var_27.addAlias("sh_crr_ri_470_1_0","sh_std_fx26_1_1_1_0");
         var_27.addAlias("sh_crr_ri_470_2_0","sh_std_fx26_1_1_2_0");
         var_27.addAlias("sh_crr_ri_470_3_0","sh_std_fx26_1_1_3_0");
         var_27.addAlias("sh_crr_ri_470_4_0","sh_std_fx26_1_1_4_0");
         var_27.addAlias("sh_crr_ri_470_5_0","sh_std_fx26_1_1_5_0");
         var_27.addAlias("h_drk_ri_fx16_1_0_0","h_std_fx16_1_1_0_0");
         var_27.addAlias("h_drk_ri_fx16_1_1_0","h_std_fx16_1_1_1_0");
         var_27.addAlias("h_drk_ri_fx16_1_2_0","h_std_fx16_1_1_2_0");
         var_27.addAlias("h_drk_ri_fx16_1_3_0","h_std_fx16_1_1_3_0");
         var_27.addAlias("h_drk_ri_fx16_1_4_0","h_std_fx16_1_1_4_0");
         var_27.addAlias("h_drk_ri_fx16_1_5_0","h_std_fx16_1_1_5_0");
         var_27.addAlias("h_drk_ri_fx16_1_6_0","h_std_fx16_1_1_6_0");
      }
      
      private function paletteTest() : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc1_:XML = _assets.getAssetByName("TestPalette").content as XML;
         var _loc2_:PaletteMap = new PaletteMap(_loc1_);
         var _loc3_:BitmapDataAsset = var_27.getAssetByName("h_lay_hrb_23_2_0") as BitmapDataAsset;
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.content as BitmapData;
            _loc5_ = _loc4_.getPixels(_loc4_.rect);
            Logger.log(_loc4_.width * _loc4_.height + " " + _loc5_.length);
            _loc6_ = _loc2_.colorize(_loc5_);
            _loc7_ = new BitmapData(_loc4_.width,_loc4_.height);
            _loc7_.setPixels(_loc7_.rect,_loc6_);
            _loc8_ = new Bitmap(_loc7_);
            var_192.addChild(_loc8_);
         }
      }
      
      public function createAvatarImage(param1:String, param2:String) : IAvatarImage
      {
         var _loc3_:AvatarStructure = var_499.getValue(AvatarType.const_118) as AvatarStructure;
         if(_loc3_ == null)
         {
            return null;
         }
         return new AvatarImage(_loc3_,var_27,param1,param2,AvatarType.const_118);
      }
   }
}
