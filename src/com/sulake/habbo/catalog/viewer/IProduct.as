package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   import flash.display.BitmapData;
   
   public interface IProduct extends IGetImageListener
   {
       
      
      function get productCount() : int;
      
      function get productClassId() : int;
      
      function initIcon(param1:IProductContainer, param2:IGetImageListener = null) : BitmapData;
      
      function set view(param1:IWindowContainer) : void;
      
      function set grid(param1:IItemGrid) : void;
      
      function get expiration() : int;
      
      function get productType() : String;
      
      function get productData() : IProductData;
      
      function get furnitureData() : IFurnitureData;
      
      function get extraParam() : String;
      
      function dispose() : void;
   }
}
