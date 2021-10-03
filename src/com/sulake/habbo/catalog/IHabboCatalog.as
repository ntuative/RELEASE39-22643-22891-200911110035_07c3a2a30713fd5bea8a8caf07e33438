package com.sulake.habbo.catalog
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.habbo.catalog.purse.IPurse;
   import com.sulake.habbo.catalog.recycler.IRecycler;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   
   public interface IHabboCatalog extends IUnknown
   {
       
      
      function loadCatalogPage(param1:int) : void;
      
      function get assets() : IAssetLibrary;
      
      function getRecyclerPrizes() : void;
      
      function getFurnitureData(param1:int) : IFurnitureData;
      
      function getRecyclerStatus() : void;
      
      function setupInventoryForRecycler(param1:Boolean) : void;
      
      function getProductData(param1:String) : IProductData;
      
      function get tradingActive() : Boolean;
      
      function openInventoryCategory(param1:String) : void;
      
      function sendRecycleItems(param1:Array) : void;
      
      function get localization() : ICoreLocalizationManager;
      
      function getPixelEffectIcon(param1:int) : BitmapData;
      
      function get windowManager() : IHabboWindowManager;
      
      function get privateRoomSessionActive() : Boolean;
      
      function get events() : IEventDispatcher;
      
      function openCatalogPage(param1:String, param2:Boolean = false) : void;
      
      function getPurse() : IPurse;
      
      function requestInventoryFurniToRecycler() : int;
      
      function redeemVoucher(param1:String) : void;
      
      function getRecycler() : IRecycler;
      
      function get configuration() : IHabboConfigurationManager;
      
      function returnInventoryFurniFromRecycler(param1:int) : Boolean;
      
      function getSubscriptionProductIcon(param1:int) : BitmapData;
      
      function redeemClubPromo(param1:String, param2:Boolean) : void;
   }
}
